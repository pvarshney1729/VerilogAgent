```verilog
module TopModule (
    input wire a,   // 1-bit input, logically treated as unsigned
    input wire b,   // 1-bit input, logically treated as unsigned
    output wire out // 1-bit output, logically treated as unsigned
);

    // Implementing NOR gate using assign statement
    assign out = ~(a | b);

endmodule
```