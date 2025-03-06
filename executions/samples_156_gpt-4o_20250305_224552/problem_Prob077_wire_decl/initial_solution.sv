module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);

    // Internal signals
    logic and_out1;
    logic and_out2;

    // First layer: AND gates
    assign and_out1 = a & b;
    assign and_out2 = c & d;

    // Second layer: OR gate
    assign out = and_out1 | and_out2;

    // Inverted output
    assign out_n = ~out;

endmodule