```verilog
module TopModule (
    input wire a,     // Single bit input
    input wire b,     // Single bit input
    input wire c,     // Single bit input
    output wire out   // Single bit output
);

    assign out = (b & ~c) | a;

endmodule
```