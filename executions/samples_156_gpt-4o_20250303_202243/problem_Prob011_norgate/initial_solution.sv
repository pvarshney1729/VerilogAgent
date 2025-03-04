```verilog
module TopModule (
    input wire a,
    input wire b,
    output wire out
);

    // Implementing the NOR gate using a continuous assignment
    assign out = ~(a | b);

endmodule
```