[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            if (q == 4'b1001) begin
                q <= 4'b0000;
            end else begin
                q <= q + 4'b0001;
            end
        end
    end
endmodule
```
[DONE]