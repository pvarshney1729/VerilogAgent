module SignExtender32 (
    input  logic [7:0] in,  // 8-bit input, assumed to be signed for sign-extension
    output logic [31:0] out // 32-bit output, result of sign-extension
);

    // Perform sign-extension by replicating the sign bit 24 times
    assign out = {{24{in[7]}}, in};

endmodule