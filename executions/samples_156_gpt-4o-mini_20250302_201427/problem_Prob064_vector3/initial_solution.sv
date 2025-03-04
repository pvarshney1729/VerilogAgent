module TopModule (
    input logic [4:0] a,
    input logic [4:0] b,
    input logic [4:0] c,
    input logic [4:0] d,
    input logic [4:0] e,
    input logic [4:0] f,
    output logic [7:0] w,
    output logic [7:0] x,
    output logic [7:0] y,
    output logic [7:0] z
);

    logic [29:0] concatenated_input;
    logic [31:0] extended_input;

    assign concatenated_input = {a, b, c, d, e, f};
    assign extended_input = {concatenated_input, 2'b11};

    assign w = extended_input[31:24];
    assign x = extended_input[23:16];
    assign y = extended_input[15:8];
    assign z = extended_input[7:0];

endmodule