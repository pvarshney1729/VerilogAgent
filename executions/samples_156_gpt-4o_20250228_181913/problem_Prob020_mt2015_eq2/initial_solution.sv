```verilog
module TopModule (
    input  [1:0] A,  // 2-bit input, A[1] is MSB, A[0] is LSB
    input  [1:0] B,  // 2-bit input, B[1] is MSB, B[0] is LSB
    output logic z   // 1-bit output
);

    // Combinational logic for equality check
    assign z = (A == B);

endmodule
```