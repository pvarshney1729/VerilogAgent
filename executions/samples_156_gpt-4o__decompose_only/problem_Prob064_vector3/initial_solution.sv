module TopModule(
    input  [4:0] a,
    input  [4:0] b,
    input  [4:0] c,
    input  [4:0] d,
    input  [4:0] e,
    input  [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);

    // Concatenate the input vectors and append two 1 bits
    wire [31:0] concatenated_inputs;
    assign concatenated_inputs = {a, b, c, d, e, f, 2'b11};

    // Split the 32-bit concatenated vector into four 8-bit outputs
    assign w = concatenated_inputs[31:24];
    assign x = concatenated_inputs[23:16];
    assign y = concatenated_inputs[15:8];
    assign z = concatenated_inputs[7:0];

endmodule