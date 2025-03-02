```verilog
module TopModule (
    input wire in1,  // 1-bit input
    input wire in2,  // 1-bit input
    input wire in3,  // 1-bit input
    output wire out  // 1-bit output
);

    assign out = ~((in1 ^ in2) ^ in3);

endmodule
```