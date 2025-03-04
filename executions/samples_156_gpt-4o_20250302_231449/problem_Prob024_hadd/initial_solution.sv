```verilog
module TopModule(
    input  wire a,   // 1-bit input signal 'a'
    input  wire b,   // 1-bit input signal 'b'
    output wire sum, // 1-bit output signal representing the sum of 'a' and 'b'
    output wire cout // 1-bit output signal representing the carry-out of the addition
);

    // Combinational logic for half adder
    assign sum = a ^ b;  // XOR operation for sum
    assign cout = a & b; // AND operation for carry-out

endmodule
```