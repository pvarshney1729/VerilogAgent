```verilog
module TopModule (
    input logic a,    // 1-bit input signal
    input logic b,    // 1-bit input signal
    output logic out  // 1-bit output signal
);

    assign out = ~(a | b); // NOR operation

endmodule
```