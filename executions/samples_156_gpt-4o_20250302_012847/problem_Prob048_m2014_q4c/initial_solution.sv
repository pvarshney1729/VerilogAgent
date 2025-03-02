```verilog
module TopModule (
    input wire clk,   // Clock input
    input wire d,     // Data input
    input wire r,     // Synchronous reset input
    output reg q      // Output
);

    // On the rising edge of the clock
    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0; // Reset output to 0
        end else begin
            q <= d;    // Follow the input d
        end
    end

endmodule
```