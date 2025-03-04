```verilog
module TopModule (
    input wire a,    // Single bit input
    input wire b,    // Single bit input
    output wire sum, // Single bit output for sum
    output wire cout // Single bit output for carry-out
);

    // Logic implementation
    assign sum = a ^ b;  // XOR operation for sum
    assign cout = a & b; // AND operation for carry-out

endmodule
```