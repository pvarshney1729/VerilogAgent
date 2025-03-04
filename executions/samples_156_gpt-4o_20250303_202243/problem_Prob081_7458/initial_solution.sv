```verilog
module TopModule (
    input wire p1a, p1b, p1c, p1d, p1e, p1f,
    input wire p2a, p2b, p2c, p2d,
    output wire p1y, p2y
);

    wire and1_out, and2_out, and3_out, and4_out;

    // Intermediate AND gates
    assign and1_out = p1a & p1b & p1c;
    assign and2_out = p1d & p1e & p1f;
    assign and3_out = p2a & p2b;
    assign and4_out = p2c & p2d;

    // Output OR gates
    assign p1y = and1_out | and2_out;
    assign p2y = and3_out | and4_out;

endmodule
```