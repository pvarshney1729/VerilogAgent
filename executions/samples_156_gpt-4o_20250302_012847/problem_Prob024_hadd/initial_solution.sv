```verilog
module TopModule (
    input logic a,   // 1-bit input, unsigned
    input logic b,   // 1-bit input, unsigned
    output logic sum, // 1-bit output, unsigned
    output logic cout // 1-bit output, unsigned
);

    // Combinational logic for half adder
    assign sum = a ^ b;   // XOR operation for sum
    assign cout = a & b;  // AND operation for carry-out

endmodule
```