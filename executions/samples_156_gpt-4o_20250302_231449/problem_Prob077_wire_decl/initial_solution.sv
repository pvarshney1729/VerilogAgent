module TopModule(
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out,
    output wire out_n
);

    wire and_out1;
    wire and_out2;

    // First Layer: AND Gates
    assign and_out1 = a & b;
    assign and_out2 = c & d;

    // Second Layer: OR Gate
    assign out = and_out1 | and_out2;

    // Inversion: NOT Gate
    assign out_n = ~out;

endmodule