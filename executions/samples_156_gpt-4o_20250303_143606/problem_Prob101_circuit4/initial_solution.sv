```verilog
module TopModule (
    input logic a,  // 1-bit input signal
    input logic b,  // 1-bit input signal
    input logic c,  // 1-bit input signal
    input logic d,  // 1-bit input signal
    output logic q  // 1-bit output signal
);

    assign q = b | (c & ~d);

endmodule
```