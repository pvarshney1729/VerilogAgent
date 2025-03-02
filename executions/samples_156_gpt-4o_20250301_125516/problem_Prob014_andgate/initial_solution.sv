```verilog
module TopModule (
    input  logic a,  // 1-bit input signal 'a', unsigned
    input  logic b,  // 1-bit input signal 'b', unsigned
    output logic out // 1-bit output signal 'out', result of AND operation
);

// Implementation
assign out = a & b;

endmodule
```