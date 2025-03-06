```verilog
module TopModule (
    input logic clk,        // Clock input, triggers on the positive edge
    input logic reset,      // Active high synchronous reset input
    output logic [3:0] q    // 4-bit output representing the counter value
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (q == 4'b1001) begin
            q <= 4'b0000;
        end else begin
            q <= q + 1;
        end
    end

endmodule
```