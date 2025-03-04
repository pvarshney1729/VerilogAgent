```verilog
module TopModule (
    input  wire in,   // 1-bit input signal
    output wire out   // 1-bit output signal
);

    // Direct wire connection from input to output
    assign out = in;

endmodule
```