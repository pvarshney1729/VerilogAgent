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

    logic [31:0] intermediate;

    assign intermediate = {a, b, c, d, e, f, 2'b11};

    assign w = intermediate[31:24];
    assign x = intermediate[23:16];
    assign y = intermediate[15:8];
    assign z = intermediate[7:0];

endmodule