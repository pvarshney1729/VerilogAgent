```verilog
module TopModule (
    input logic [3:0] x,
    output logic f
);

always @(*) begin
    f = (4'b0000 & ~x[3] & ~x[2] & ~x[1] & ~x[0]) | 
        (4'b0001 & ~x[3] & x[2] & x[1] & x[0]) | 
        (4'b0001 & x[3] & ~x[2] & ~x[1]) | 
        (4'b0001 & x[3] & x[2] & ~x[0]);
end

endmodule
```