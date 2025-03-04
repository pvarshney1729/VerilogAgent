module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    input logic done_counting,
    input logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        COUNTING = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] shift_counter;

    // State register
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 2'b00;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (data == 1'b1) // Assuming data is the last bit of the sequence 1101
                    next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11)
                    next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

endmodule