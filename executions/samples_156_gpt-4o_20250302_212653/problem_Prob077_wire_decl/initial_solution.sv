module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);

    logic and1_out;
    logic and2_out;

    // Layer 1: AND gates
    assign and1_out = a & b;
    assign and2_out = c & d;

    // Layer 2: OR gate and NOT gate
    assign out = and1_out | and2_out;
    assign out_n = ~out;

endmodule