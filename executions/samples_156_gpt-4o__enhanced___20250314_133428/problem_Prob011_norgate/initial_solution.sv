```verilog
module TopModule(
    input logic a,    // Single-bit input
    input logic b,    // Single-bit input
    output logic out  // Single-bit output
);
    // Implementing the NOR operation
    assign out = ~(a | b);

endmodule
```