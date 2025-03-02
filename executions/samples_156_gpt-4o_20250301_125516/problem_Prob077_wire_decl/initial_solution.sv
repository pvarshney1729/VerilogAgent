```verilog
module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);
    logic and1_out; // Intermediate wire for AND gate 1 output
    logic and2_out; // Intermediate wire for AND gate 2 output

    // First layer: AND gates
    assign and1_out = a & b;
    assign and2_out = c & d;

    // Second layer: OR gate
    assign out = and1_out | and2_out;

    // Inverted output
    assign out_n = ~out;
endmodule
```