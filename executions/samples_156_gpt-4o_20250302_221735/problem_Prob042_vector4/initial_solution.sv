module TopModule(
    input wire signed [7:0] in,
    output wire signed [31:0] out
);

    // Perform sign-extension by concatenating 24 copies of the sign bit with the input
    assign out = {{24{in[7]}}, in};

endmodule