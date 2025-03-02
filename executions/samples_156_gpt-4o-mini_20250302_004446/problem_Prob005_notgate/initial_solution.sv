```verilog
module TopModule (
    input logic in,   // Single-bit input
    output logic out  // Single-bit output
);
    assign out = ~in; // NOT operation
endmodule
```