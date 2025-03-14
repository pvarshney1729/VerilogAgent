module TopModule (
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
    logic [29:0] concatenated_inputs;

    assign concatenated_inputs = {a, b, c, d, e, f};

    assign w = {concatenated_inputs[29:22], 2'b11}; // w = bits 29 to 22 + 11
    assign x = {concatenated_inputs[21:14], 2'b11}; // x = bits 21 to 14 + 11
    assign y = {concatenated_inputs[13:6], 2'b11};  // y = bits 13 to 6 + 11
    assign z = {concatenated_inputs[5:0], 2'b11};   // z = bits 5 to 0 + 11
endmodule