```verilog
module TopModule (
    input logic clk,  // Clock signal
    input logic d,    // Data input
    input logic r,    // Synchronous active high reset
    output logic q    // Output of the flip-flop
);

always @(posedge clk) begin
    if (r) begin
        q <= 1'b0;  // Reset output to 0
    end else begin
        q <= d;     // Capture data input
    end
end

endmodule
```