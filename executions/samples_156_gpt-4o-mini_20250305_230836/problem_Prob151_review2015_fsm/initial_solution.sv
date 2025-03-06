```verilog
module TopModule (
    input logic clk,                  // Clock signal, positive edge-triggered
    input logic reset,                // Active high synchronous reset
    input logic data,                 // Serial data input for pattern detection
    input logic done_counting,        // Input signal indicating counting completion
    input logic ack,                  // User acknowledgment input

    output logic shift_ena,           // Output: Shift enable, active during data shift
    output logic counting,             // Output: Counting state indicator
    output logic done                  // Output: Timer done indicator
);

    typedef enum logic [1:0] {
        IDLE,
        PATTERN_DETECTED,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_counter <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == PATTERN_DETECTED) begin
                if (shift_counter < 4'b0100) begin
                    shift_counter <= shift_counter + 4'b0001;
                end else begin
                    shift_counter <= 4'b0000;
                end
            end else begin
                shift_counter <= 4'b0000;
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
                if (data == 1'b1) begin
                    next_state = PATTERN_DETECTED;
                end
            end

            PATTERN_DETECTED: begin
                shift_ena = 1'b1;
                if (shift_counter == 4'b0011) begin
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
```