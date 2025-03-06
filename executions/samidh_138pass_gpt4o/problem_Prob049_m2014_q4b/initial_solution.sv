```verilog
[BEGIN]
module TopModule (
    input logic clk,   // Clock signal
    input logic ar,    // Asynchronous reset, active high
    input logic d,     // Data input
    output logic q     // D flip-flop output
);

// D flip-flop with asynchronous reset
always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 1'b0; // Reset state
    end else begin
        q <= d;    // Capture data on rising edge of clock
    end
end

endmodule
[DONE]
```