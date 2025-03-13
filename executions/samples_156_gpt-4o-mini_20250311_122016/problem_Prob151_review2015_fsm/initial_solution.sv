```
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
    typedef enum logic [2:0] {
        IDLE         = 3'b000,
        DETECT1      = 3'b001,
        DETECT11     = 3'b010,
        DETECT110    = 3'b011,
        DETECT1101   = 3'b100,
        SHIFT        = 3'b101,
        COUNTING     = 3'b110,
        DONE         = 3'b111
    } state_t;

    state_t current_state, next_state;
    logic [1:0] shift_counter; // Counter for 4 cycles of shift_ena
    logic [3:0] pattern_reg;   // Register to hold the pattern

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            pattern_reg <= 4'b0000;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == DETECT1 || current_state == DETECT11 || current_state == DETECT110) begin
                pattern_reg <= {pattern_reg[2:0], data};  // Shift in new data
            end
            if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 2'b00;
            end
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default outputs
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = current_state; // Default to no state change

        case (current_state)
            IDLE: begin
                if (data) begin
                    next_state = DETECT1;
                end
            end
            DETECT1: begin
                if (data) begin
                    next_state = DETECT11;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT11: begin
                if (!data) begin
                    next_state = DETECT110;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT110: begin
                if (data) begin
                    next_state = DETECT1101;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT1101: begin
                next_state = SHIFT;
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
            default: next_state = IDLE;
        endcase
    end

endmodule
[DONE]
```