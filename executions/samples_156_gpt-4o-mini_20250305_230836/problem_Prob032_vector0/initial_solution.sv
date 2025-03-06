[BEGIN]
```verilog
module TopModule (
    input logic [2:0] vec,  // 3-bit input vector, bit[0] is LSB, bit[2] is MSB
    output logic [2:0] outv, // 3-bit output vector, directly mirrors 'vec'
    output logic o2,         // 1-bit output, corresponds to vec[2]
    output logic o1,         // 1-bit output, corresponds to vec[1]
    output logic o0          // 1-bit output, corresponds to vec[0]
);

always @(*) begin
    outv = vec;
    o2 = vec[2];
    o1 = vec[1];
    o0 = vec[0];
end

endmodule
```
[DONE]