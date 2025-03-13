[BEGIN]
module TopModule (
    input  logic clk,     // Clock signal, active on rising edge
    input  logic reset,   // Active-high synchronous reset
    input  logic in,      // 1-bit input signal
    output logic out      // 1-bit output signal
);

    // State encoding
    localparam STATE_B = 1'b0;
    localparam STATE_A = 1'b1;

    // State register
    logic current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B; // Reset state to B
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B; // Default to STATE_B
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1; // Default output
        endcase
    end

endmodule
[DONE]