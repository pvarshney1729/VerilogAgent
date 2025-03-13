```verilog
[BEGIN]
module TopModule (
    input logic clk,           // Clock signal, positive edge triggered
    input logic async_reset,   // Asynchronous reset signal, active high
    input logic d,             // Data input for the D flip-flop
    output logic q             // Data output of the D flip-flop
);

always @(posedge clk) begin
    if (async_reset) begin
        q <= 1'b0;
    end else begin
        q <= d;
    end
end

endmodule
[DONE]
```