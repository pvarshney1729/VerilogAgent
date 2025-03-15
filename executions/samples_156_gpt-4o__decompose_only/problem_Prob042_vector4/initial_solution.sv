module TopModule(
    input  logic [7:0] in,
    output logic [31:0] out
);

    // Sign-extend the 8-bit input to 32 bits
    assign out = {{24{in[7]}}, in};

endmodule