```verilog
module pattern_detector (
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
        COUNT = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;
    logic [3:0] pattern_shift_reg;

    // State register
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 4'b0000;
            pattern_shift_reg <= 4'b0000;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT)
                shift_counter <= shift_counter + 1'b1;
            else
                shift_counter <= 4'b0000;
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
                pattern_shift_reg = {pattern_shift_reg[2:0], data};
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = SHIFT;
                end
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 4'b0011) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
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
```