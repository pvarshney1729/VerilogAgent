```verilog
module TopModule (
    input wire in1,    // Single-bit input
    input wire in2,    // Single-bit input
    input wire in3,    // Single-bit input
    output wire out    // Single-bit output
);

    // Combinational logic for the output
    assign out = (in1 ~^ in2) ^ in3;

endmodule
```