```verilog
module TopModule (
    input logic a,  // 1-bit input, unsigned
    input logic b,  // 1-bit input, unsigned
    input logic c,  // 1-bit input, unsigned
    input logic d,  // 1-bit input, unsigned
    output logic out,  // 1-bit output, unsigned
    output logic out_n  // 1-bit output, inverted signal of `out`, unsigned
);

    logic and1_out;  // Intermediate wire for first AND gate
    logic and2_out;  // Intermediate wire for second AND gate

    // Combinational logic
    assign and1_out = a & b;  // First AND gate
    assign and2_out = c & d;  // Second AND gate
    assign out = and1_out | and2_out;  // OR gate
    assign out_n = ~out;  // NOT gate for inverted output

endmodule
```