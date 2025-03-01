module TopModule (
    input  wire signed [7:0] in,  // 8-bit signed input
    output wire signed [31:0] out // 32-bit signed output
);

    // Sign-extend the 8-bit input to a 32-bit output
    assign out = { {24{in[7]}}, in };

endmodule