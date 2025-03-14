```verilog
module TopModule (
    input logic clk,            // Clock input (rising edge triggered)
    input logic d,              // Data input (1-bit, unsigned)
    input logic r,              // Active high synchronous reset input (1-bit, unsigned)
    output logic q              // Output (1-bit, unsigned)
);

always @(posedge clk) begin
    if (r) begin
        q <= 1'b0; // Synchronous reset
    end else begin
        q <= d; // Capture data on clock edge
    end
end

endmodule
```