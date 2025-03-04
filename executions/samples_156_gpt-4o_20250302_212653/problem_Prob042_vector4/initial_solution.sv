module TopModule (
    input  logic signed [7:0] in,    // 8-bit signed input
    output logic signed [31:0] out   // 32-bit signed output
);

    // Sign-extension operation
    assign out = {{24{in[7]}}, in};

endmodule