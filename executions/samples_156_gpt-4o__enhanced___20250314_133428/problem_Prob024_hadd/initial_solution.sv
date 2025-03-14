```verilog
module TopModule (
    input logic a,
    input logic b,
    output logic sum,
    output logic cout
);
    // XOR for sum
    assign sum = a ^ b;
    // AND for carry-out
    assign cout = a & b;
endmodule
```