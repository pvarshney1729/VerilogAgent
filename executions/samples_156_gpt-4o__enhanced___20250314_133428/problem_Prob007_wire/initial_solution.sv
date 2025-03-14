```verilog
module TopModule (
    input logic in,  // Single-bit input
    output logic out // Single-bit output
);
    // Direct assignment to implement wire behavior
    assign out = in;
endmodule
```