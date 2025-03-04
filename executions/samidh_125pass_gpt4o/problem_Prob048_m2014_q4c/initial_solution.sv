```verilog
module TopModule (
    input logic clk,   // Clock input
    input logic d,     // Data input
    input logic r,     // Synchronous reset input
    output logic q     // Output
);

    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0; // Reset output to 0
        end else begin
            q <= d;    // Store data input
        end
    end
endmodule
```