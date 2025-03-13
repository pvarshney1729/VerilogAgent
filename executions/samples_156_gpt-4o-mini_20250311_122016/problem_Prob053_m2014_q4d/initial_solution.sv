[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic in,
    output logic out
);
    logic xor_out;

    always @(*) begin
        xor_out = in ^ out;
    end

    always @(posedge clk) begin
        out <= xor_out;
    end
endmodule
```
[DONE]