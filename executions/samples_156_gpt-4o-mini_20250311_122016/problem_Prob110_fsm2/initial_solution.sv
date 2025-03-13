```
[BEGIN]
module TopModule (
    input logic clk,       // Clock signal, used for synchronizing state transitions
    input logic areset,    // Asynchronous active-high reset, resets state to OFF
    input logic j,         // Input signal for state transition decision
    input logic k,         // Input signal for state transition decision
    output logic out       // Output signal reflecting the current state (0 for OFF, 1 for ON)
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        out <= 1'b0; // State OFF
    end else begin
        case (out)
            1'b0: out <= j ? 1'b1 : 1'b0; // OFF: j=1 -> ON, j=0 -> OFF
            1'b1: out <= k ? 1'b0 : 1'b1; // ON: k=1 -> OFF, k=0 -> ON
        endcase
    end
end

endmodule
[DONE]
```