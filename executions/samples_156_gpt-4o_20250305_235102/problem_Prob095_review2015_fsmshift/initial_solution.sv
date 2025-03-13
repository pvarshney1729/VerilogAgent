```verilog
[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RESET_SEQ = 2'b01,
        PATTERN_SEQ = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [2:0] cycle_count;
    logic pattern_detected;

    // Pattern detection logic (assumed to be provided externally)
    always_ff @(posedge clk) begin
        if (reset) begin
            pattern_detected <= 1'b0;
        end else begin
            // Assume pattern_detected is set by external logic
            pattern_detected <= /* logic to detect pattern */;
        end
    end

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE; // Set to IDLE on reset
            cycle_count <= 3'b000;
            shift_ena <= 1'b0; // Ensure shift_ena is also reset
        end else begin
            current_state <= next_state;
            if (next_state == RESET_SEQ || next_state == PATTERN_SEQ) begin
                cycle_count <= cycle_count + 1;
            end else begin
                cycle_count <= 3'b000;
            end
        end
    end

    // Next state logic
    always_ff @(current_state, pattern_detected) begin
        next_state = current_state;
        shift_ena = 1'b0;

        case (current_state)
            IDLE: begin
                if (pattern_detected) begin
                    next_state = PATTERN_SEQ;
                end
            end

            RESET_SEQ: begin
                shift_ena = 1'b1;
                if (cycle_count == 3'b011) begin
                    next_state = IDLE;
                end
            end

            PATTERN_SEQ: begin
                shift_ena = 1'b1;
                if (cycle_count == 3'b011) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
[DONE]
```