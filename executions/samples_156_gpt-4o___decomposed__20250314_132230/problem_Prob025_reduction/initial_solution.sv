module TopModule(
    input  logic [7:0] in,
    output logic parity
);

    // Compute even parity by XORing all bits of 'in'
    assign parity = ^in;

endmodule