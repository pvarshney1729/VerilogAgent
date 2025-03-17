module TopModule(
    input  logic [4:0] a,
    input  logic [4:0] b,
    input  logic [4:0] c,
    input  logic [4:0] d,
    input  logic [4:0] e,
    input  logic [4:0] f,
    output logic [7:0] w,
    output logic [7:0] x,
    output logic [7:0] y,
    output logic [7:0] z
);

    logic [31:0] concatenated_output;

    // Concatenate inputs and append two '1' bits
    assign concatenated_output = {a, b, c, d, e, f, 2'b11};

    // Assign 8-bit segments to outputs
    assign w = concatenated_output[31:24];
    assign x = concatenated_output[23:16];
    assign y = concatenated_output[15:8];
    assign z = concatenated_output[7:0];

endmodule