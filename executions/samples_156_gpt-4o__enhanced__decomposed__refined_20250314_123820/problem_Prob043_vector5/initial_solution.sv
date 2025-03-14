module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);

    assign out[0] = (e == e);
    assign out[1] = (e == d);
    assign out[2] = (e == c);
    assign out[3] = (e == b);
    assign out[4] = (e == a);

    assign out[5] = (d == d);
    assign out[6] = (d == c);
    assign out[7] = (d == b);
    assign out[8] = (d == a);

    assign out[9] = (c == c);
    assign out[10] = (c == b);
    assign out[11] = (c == a);

    assign out[12] = (b == b);
    assign out[13] = (b == a);

    assign out[14] = (a == a);

    assign out[15] = 1'b0; // Unused bit
    assign out[16] = 1'b0; // Unused bit
    assign out[17] = 1'b0; // Unused bit
    assign out[18] = 1'b0; // Unused bit
    assign out[19] = 1'b0; // Unused bit
    assign out[20] = 1'b0; // Unused bit
    assign out[21] = 1'b0; // Unused bit
    assign out[22] = 1'b0; // Unused bit
    assign out[23] = 1'b0; // Unused bit
    assign out[24] = 1'b0; // Unused bit

endmodule