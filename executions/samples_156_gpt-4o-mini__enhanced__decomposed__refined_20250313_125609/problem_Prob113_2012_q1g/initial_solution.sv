```verilog
[BEGIN]
module TopModule (
    input logic [3:0] x,
    output logic f
);

always @(*) begin
    f = (x == 4'b0000) || (x == 4'b0011) || (x == 4'b0100) || 
        (x == 4'b1000) || (x == 4'b1001) || (x == 4'b1011) || 
        (x == 4'b1100) || (x == 4'b1110);
end

endmodule
[DONE]
```