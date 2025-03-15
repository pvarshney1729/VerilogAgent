module TopModule(
    input  logic [5:0] y,
    input  logic       w,
    output logic       Y1,
    output logic       Y3
);

// Output logic for Y1 and Y3 based on state transitions
assign Y1 = (y[0] & ~w) | (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & w) | (y[5] & w);
assign Y3 = (y[3] & ~w) | (y[2] & ~w); // Corrected logic for Y3

endmodule