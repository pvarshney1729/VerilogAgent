module TopModule(
    input logic clk,              // Clock signal, positive edge-triggered
    input logic reset,            // Synchronous active-high reset
    input logic data,             // Serial data input, 1-bit
    input logic done_counting,    // Signal indicating counting completion, 1-bit
    input logic ack,              // Acknowledgment signal from user, 1-bit
    output logic shift_ena,       // Enable signal for shifting, 1-bit
    output logic counting,        // Signal indicating counting is in progress, 1-bit
    output logic done             // Signal indicating timer completion, 1-bit
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        COUNTING = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] sequence;
    logic [1:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            sequence <= 4'b0000;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == IDLE) begin
                sequence <= {sequence[2:0], data};
            end else if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (sequence == 4'b1101) begin
                    next_state = SHIFT;
                end
            end

            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) begin
                    next_state = COUNTING;
                end
            end

            COUNTING: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end

            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule