```verilog
module TopModule (
    input [1:0] A,  // 2-bit input, A[1] is MSB, A[0] is LSB
    input [1:0] B,  // 2-bit input, B[1] is MSB, B[0] is LSB
    output reg z    // 1-bit output, reg type for procedural assignment
);

    always @(*) begin
        if (A == B)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
```