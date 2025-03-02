```verilog
module TopModule (
    logic a,
    logic b,
    logic sum,
    logic cout
);
    assign sum = a ^ b;  // XOR operation for sum
    assign cout = a & b; // AND operation for carry-out
endmodule
```