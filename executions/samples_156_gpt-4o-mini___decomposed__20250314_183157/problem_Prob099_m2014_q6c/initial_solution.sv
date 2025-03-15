module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

assign Y1 = (y[0] & w) | (y[1] & ~w); // Logic for next-state signal Y1
assign Y3 = (y[2] & ~w) | (y[3] & w); // Logic for next-state signal Y3

endmodule