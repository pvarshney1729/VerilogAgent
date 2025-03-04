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

    // Concatenate inputs and constant to form a 32-bit vector
    wire [31:0] input_concat = {a, b, c, d, e, f, 2'b11};

    // Assign the 32-bit vector to the 8-bit outputs
    assign w = input_concat[31:24];
    assign x = input_concat[23:16];
    assign y = input_concat[15:8];
    assign z = input_concat[7:0];

endmodule