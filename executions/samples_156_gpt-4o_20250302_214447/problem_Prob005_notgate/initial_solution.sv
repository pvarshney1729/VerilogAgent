```verilog
module TopModule (
    input logic in,   // Single-bit input signal
    output logic out  // Single-bit output signal
);
    // NOT gate implementation
    assign out = ~in;
endmodule
```