```verilog
module TopModule (
    input  logic [2:0] a,              // 3-bit unsigned input vector
    input  logic [2:0] b,              // 3-bit unsigned input vector
    output logic [2:0] out_or_bitwise, // 3-bit unsigned output for bitwise OR
    output logic       out_or_logical, // Single-bit unsigned output for logical OR
    output logic [5:0] out_not         // 6-bit unsigned output for NOT operation
);

    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation
    assign out_or_logical = (a != 3'b000) || (b != 3'b000);

    // NOT operation
    assign out_not[5:3] = ~b;
    assign out_not[2:0] = ~a;

endmodule
```