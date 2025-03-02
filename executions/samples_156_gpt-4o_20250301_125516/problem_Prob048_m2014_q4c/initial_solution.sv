```verilog
module TopModule (
    input wire clk,  // Clock input
    input wire d,    // Data input
    input wire r,    // Synchronous active high reset
    output reg q     // Output
);

// Initial state
initial begin
    q = 0;  // Initialize output to 0
end

always @(posedge clk) begin
    if (r) begin
        q <= 0;  // Reset output to 0
    end else begin
        q <= d;  // Capture input data
    end
end

endmodule
```