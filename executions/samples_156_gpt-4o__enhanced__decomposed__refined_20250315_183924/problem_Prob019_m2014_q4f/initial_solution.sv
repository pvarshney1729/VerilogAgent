```verilog
module TopModule (
    input wire in1,  // Single-bit input
    input wire in2,  // Single-bit input, active-low due to bubble
    output wire out  // Single-bit output
);

    // Implement the AND gate with in2 inverted
    assign out = in1 & ~in2;

endmodule
```