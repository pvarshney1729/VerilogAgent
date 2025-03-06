module TopModule (
    input logic [7:0] in,   // 8-bit signed input
    output logic [31:0] out // 32-bit signed output
);

    // Combinational logic for sign-extension
    assign out = {{24{in[7]}}, in};

endmodule