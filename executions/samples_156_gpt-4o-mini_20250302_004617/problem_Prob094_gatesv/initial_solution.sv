module combinational_logic (
    input logic [3:0] in_a,
    input logic [3:0] in_b,
    output logic [3:0] out_both,
    output logic [3:0] out_any,
    output logic out_different
);

    // Combinational logic for out_both
    assign out_both = in_a & in_b;

    // Combinational logic for out_any
    assign out_any = in_a | in_b;

    // Combinational logic for out_different
    assign out_different = (in_a != in_b);

endmodule