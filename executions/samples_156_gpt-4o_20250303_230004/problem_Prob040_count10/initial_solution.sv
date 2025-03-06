```verilog
module TopModule (
    input wire clk,          // Clock input
    input wire reset,        // Active high synchronous reset
    output reg [3:0] q       // 4-bit unsigned output
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;  // Reset the counter to 0
        end else begin
            if (q == 4'b1001) begin
                q <= 4'b0000;  // Wrap back to 0 after reaching 9
            end else begin
                q <= q + 1'b1;  // Increment the counter
            end
        end
    end

endmodule
```