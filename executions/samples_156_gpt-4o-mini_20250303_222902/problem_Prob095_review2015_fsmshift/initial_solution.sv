module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE,
        WAIT_FOR_PATTERN,
        ENABLE_SHIFT,
        HOLD
    } state_t;

    state_t current_state, next_state;
    logic [3:0] cycle_count;
    logic pattern_detected; // Assume this is generated from some input logic

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            cycle_count <= 4'b0;
            shift_ena <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == ENABLE_SHIFT) begin
                cycle_count <= cycle_count + 1;
                if (cycle_count == 4'b0011) begin
                    shift_ena <= 1'b0; // De-assert after 4 cycles
                end
            end else if (current_state == IDLE || current_state == HOLD) begin
                cycle_count <= 4'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = ENABLE_SHIFT;
                end else begin
                    next_state = IDLE;
                end
            end
            WAIT_FOR_PATTERN: begin
                if (pattern_detected) begin
                    next_state = ENABLE_SHIFT;
                end else begin
                    next_state = WAIT_FOR_PATTERN;
                end
            end
            ENABLE_SHIFT: begin
                if (cycle_count < 4'b0011) begin
                    next_state = ENABLE_SHIFT;
                end else begin
                    next_state = HOLD;
                end
            end
            HOLD: begin
                next_state = WAIT_FOR_PATTERN;
            end
            default: next_state = IDLE;
        endcase
    end

    // Pattern detection logic (to be defined based on specific requirements)
    // This is a placeholder for actual pattern detection logic
    assign pattern_detected = /* Your pattern detection logic here */;

endmodule