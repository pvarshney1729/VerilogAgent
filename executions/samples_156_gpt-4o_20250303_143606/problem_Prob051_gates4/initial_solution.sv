module TopModule (
    input logic [3:0] data_in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for out_and
    assign out_and = &data_in;

    // Combinational logic for out_or
    assign out_or = |data_in;

    // Combinational logic for out_xor
    assign out_xor = ^data_in;

endmodule