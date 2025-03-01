```verilog
module TopModule (
    input wire in1,  // 1-bit input signal
    input wire in2,  // 1-bit input signal (inverted before AND gate)
    output wire out  // 1-bit output signal
);

    // Perform the AND operation with in1 and the inverted in2
    assign out = in1 & ~in2;

endmodule
```