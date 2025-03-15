module TopModule(
    input logic [7:0] in,  // 8-bit input
    output logic parity    // 1-bit output for parity
);

    // Compute even parity using reduction XOR
    assign parity = ^in;

endmodule