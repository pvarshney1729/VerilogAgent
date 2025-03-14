```verilog
[BEGIN]
module TopModule (
    input  logic [7:0] in,  
    output logic [7:0] out  
);

always @(*) begin
    out = {in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]};
end

endmodule
[DONE]
```