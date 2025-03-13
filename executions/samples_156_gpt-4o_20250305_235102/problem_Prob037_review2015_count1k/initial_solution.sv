```verilog
[BEGIN]
module TopModule (
    input logic clk,           // Clock input, active on the positive edge
    input logic reset,         // Synchronous active-high reset
    output logic [9:0] q       // 10-bit counter output, unsigned
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b0000000000;
        end else if (q == 10'd999) begin
            q <= 10'b0000000000;
        end else begin
            q <= q + 10'd1;
        end
    end

endmodule
[DONE]
```