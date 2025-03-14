[BEGIN]
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

    // State encoding
    typedef enum logic [1:0] {
        SEARCH_PATTERN = 2'b00,
        SHIFT          = 2'b01,
        WAIT_COUNT     = 2'b10,
        DONE           = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] pattern_shift_reg;
    logic [2:0] shift_counter;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= SEARCH_PATTERN;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            pattern_shift_reg <= 4'b0000;
            shift_counter <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == SEARCH_PATTERN) begin
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
            end
            if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end
        end
    end

    // Next state logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            SEARCH_PATTERN: begin
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = SHIFT;
                end
            end

            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'b011) begin
                    next_state = WAIT_COUNT;
                end
            end

            WAIT_COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end

            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = SEARCH_PATTERN;
                end
            end
        endcase
    end

endmodule
[DONE]