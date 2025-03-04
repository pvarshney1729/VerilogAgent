module top_module (
    input logic [3:0] in_bus,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for AND operation
    assign out_and = &in_bus;

    // Combinational logic for OR operation
    assign out_or = |in_bus;

    // Combinational logic for XOR operation
    assign out_xor = ^in_bus;

endmodule