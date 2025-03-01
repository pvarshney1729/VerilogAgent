module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);

    assign out[0] = (a == a);
    assign out[1] = (a == b);
    assign out[2] = (a == c);
    assign out[3] = (a == d);
    assign out[4] = (a == e);
    assign out[5] = (b == a);
    assign out[6] = (b == b);
    assign out[7] = (b == c);
    assign out[8] = (b == d);
    assign out[9] = (b == e);
    assign out[10] = (c == a);
    assign out[11] = (c == b);
    assign out[12] = (c == c);
    assign out[13] = (c == d);
    assign out[14] = (c == e);
    assign out[15] = (d == a);
    assign out[16] = (d == b);
    assign out[17] = (d == c);
    assign out[18] = (d == d);
    assign out[19] = (d == e);
    assign out[20] = (e == a);
    assign out[21] = (e == b);
    assign out[22] = (e == c);
    assign out[23] = (e == d);
    assign out[24] = (e == e);

endmodule