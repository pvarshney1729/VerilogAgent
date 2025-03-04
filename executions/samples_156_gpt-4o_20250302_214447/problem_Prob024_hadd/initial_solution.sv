```verilog
module TopModule (
    input wire a,         // 1-bit input
    input wire b,         // 1-bit input
    output wire sum,      // 1-bit output
    output wire cout      // 1-bit output
);

    // Logic for half adder
    assign sum = a ^ b;   // XOR operation for sum
    assign cout = a & b;  // AND operation for carry-out

endmodule
```