module TopModule(
    input logic [7:0] in,
    output logic parity
);

    // Compute even parity by XORing all bits of the input
    assign parity = ^in;

endmodule