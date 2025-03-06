```verilog
module TopModule (
    input wire in1,  // Single-bit input
    input wire in2,  // Single-bit input
    output wire out  // Single-bit output
);

    // Implementing the NOR gate logic
    assign out = ~(in1 | in2);

endmodule
```