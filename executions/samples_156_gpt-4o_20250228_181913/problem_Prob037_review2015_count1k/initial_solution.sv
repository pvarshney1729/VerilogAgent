```verilog
module TopModule (
    input wire clk,            // 1-bit clock input
    input wire reset,          // 1-bit synchronous active-high reset input
    output reg [9:0] q         // 10-bit output representing the count value
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b0000000000; // Reset to 0
        end else if (q == 10'b1111100111) begin
            q <= 10'b0000000000; // Wrap around after 999
        end else begin
            q <= q + 1;          // Increment counter
        end
    end

endmodule
```