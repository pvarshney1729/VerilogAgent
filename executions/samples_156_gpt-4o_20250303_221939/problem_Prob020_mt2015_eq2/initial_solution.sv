```verilog
module TopModule (
    input  wire [1:0] A,  // Two-bit unsigned input A
    input  wire [1:0] B,  // Two-bit unsigned input B
    output wire       z   // One-bit output z
);

    // Assign z to be 1 if A and B are equal, otherwise 0
    assign z = (A == B);

endmodule
```