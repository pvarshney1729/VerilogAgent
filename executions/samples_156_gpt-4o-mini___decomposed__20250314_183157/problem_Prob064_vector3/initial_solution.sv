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

    logic [31:0] concatenated;

    assign concatenated = {a, b, c, d, e, f, 1'b1, 1'b1};

    assign w = concatenated[7:0];
    assign x = concatenated[15:8];
    assign y = concatenated[23:16];
    assign z = concatenated[31:24];

endmodule