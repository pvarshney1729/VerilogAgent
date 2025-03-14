```verilog
[BEGIN]
module TopModule (
    input logic in,               // One-bit input signal (0 or 1)
    input logic [3:0] state,     // 4-bit input signal representing the current state (one-hot encoded)
    output logic [3:0] next_state, // 4-bit output signal for the next state (one-hot encoded)
    output logic out              // One-bit output signal
);

always @(*) begin
    // Default output values
    next_state = 4'b0000; // Default to no active state
    out = 1'b0;           // Default output

    // State Transition Logic
    case (state)
        4'b0001: begin // State A
            if (in == 1'b0) begin
                next_state = 4'b0001; // Remain in state A
            end else begin
                next_state = 4'b0010; // Transition to state B
            end
            out = 1'b0; // Output for state A
        end

        4'b0010: begin // State B
            if (in == 1'b0) begin
                next_state = 4'b0100; // Transition to state C
            end else begin
                next_state = 4'b0010; // Remain in state B
            end
            out = 1'b0; // Output for state B
        end

        4'b0100: begin // State C
            if (in == 1'b0) begin
                next_state = 4'b0001; // Transition to state A
            end else begin
                next_state = 4'b1000; // Transition to state D
            end
            out = 1'b0; // Output for state C
        end

        4'b1000: begin // State D
            if (in == 1'b0) begin
                next_state = 4'b0100; // Transition to state C
            end else begin
                next_state = 4'b0010; // Transition to state B
            end
            out = 1'b1; // Output for state D
        end

        default: begin
            next_state = 4'b0001; // Fallback to initial state A
            out = 1'b0; // Default output
        end
    endcase
end

endmodule
[DONE]
```