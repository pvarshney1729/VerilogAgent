module TopModule (
    input logic clk,                // Clock signal, positive-edge triggered
    input logic reset,              // Active high synchronous reset
    input logic data,               // Serial data input for pattern detection
    input logic done_counting,      // Input signal indicating the counter has finished
    input logic ack,                // Acknowledgment signal from the user
    output logic shift_ena,         // Output signal to enable shifting
    output logic counting,          // Output signal indicating counting state
    output logic done               // Output signal indicating timer completion
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        COUNT = 2'b10,
        NOTIFY = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] pattern_shift_reg;
    logic [1:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            pattern_shift_reg <= 4'b0000;
            shift_counter <= 2'b00;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 2'b00;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == IDLE) begin
            pattern_shift_reg <= {pattern_shift_reg[2:0], data};
        end
    end

    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = SHIFT;
                end
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = NOTIFY;
                end
            end
            NOTIFY: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule