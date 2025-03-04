module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out
);

    assign out = (~a & ~b & c) | (b & c) | (a & d);

endmodule