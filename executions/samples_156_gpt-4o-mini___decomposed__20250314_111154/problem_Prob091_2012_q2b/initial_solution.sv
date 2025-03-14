module TopModule (
    input  logic [5:0] y,
    input  logic       w,
    output logic       Y1,
    output logic       Y3
);
    assign Y1 = (y[0] & w) | (y[1] & ~w) | (y[4] & ~w) | (y[5] & ~w); // Logic derived from state transitions for Y1
    assign Y3 = (y[2] & ~w) | (y[3] & ~w) | (y[0] & w) | (y[1] & w); // Logic derived from state transitions for Y3
endmodule