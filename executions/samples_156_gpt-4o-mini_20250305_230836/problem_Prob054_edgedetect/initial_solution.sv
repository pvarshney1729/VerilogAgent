[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic [7:0] in,
    input logic reset_n,
    output logic [7:0] pedge
);

logic [7:0] prev_in;

always @(posedge clk) begin
    if (!reset_n) begin
        pedge <= 8'b00000000;
        prev_in <= 8'b00000000;
    end else begin
        pedge <= (in & ~prev_in);
        prev_in <= in;
    end
end

endmodule
```
[DONE]