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

    // Intermediate concatenated 30-bit vector
    logic [31:0] concatenated_inputs;

    // Concatenate inputs and add two '1's at the least significant positions
    assign concatenated_inputs = {a, b, c, d, e, f, 2'b11};

    // Split the 32-bit concatenated result into 8-bit outputs
    assign w = concatenated_inputs[31:24];
    assign x = concatenated_inputs[23:16];
    assign y = concatenated_inputs[15:8];
    assign z = concatenated_inputs[7:0];

endmodule