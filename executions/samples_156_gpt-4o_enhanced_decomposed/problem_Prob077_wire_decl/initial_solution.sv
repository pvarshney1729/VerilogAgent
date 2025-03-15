module TopModule(
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out,
    output logic out_n
);

    // Intermediate wires for AND gate outputs
    logic and1_out;
    logic and2_out;

    // AND gates
    assign and1_out = a & b;
    assign and2_out = c & d;

    // OR gate
    assign out = and1_out | and2_out;

    // NOT gate for inverted output
    assign out_n = ~out;

endmodule