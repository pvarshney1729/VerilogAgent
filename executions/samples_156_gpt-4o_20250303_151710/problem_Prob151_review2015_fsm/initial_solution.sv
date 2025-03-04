module TopModule (
    input logic clk,          // Clock signal
    input logic reset,        // Active high synchronous reset
    input logic data,         // Serial data input
    input logic done_counting,// Indicates the counter has finished
    input logic ack,          // Acknowledgment from the user
    output logic shift_ena,   // Enable signal for shifting
    output logic counting,    // Indicates counting state
    output logic done         // Indicates timer completion
);

    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT,
        COUNT,
        DONE
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
            if (current_state == PATTERN_DETECT) begin
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
            end
            if (current_state == SHIFT) begin
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
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = SHIFT;
                end else begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
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