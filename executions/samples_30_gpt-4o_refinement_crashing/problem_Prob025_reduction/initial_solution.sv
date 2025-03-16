module TopModule(
    input logic [7:0] in,
    output logic parity
);

    // Compute even parity using reduction XOR
    assign parity = ^in;

endmodule