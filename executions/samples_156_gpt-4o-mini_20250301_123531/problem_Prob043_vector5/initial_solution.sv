module TopModule (
    input logic a,      // 1-bit input signal
    input logic b,      // 1-bit input signal
    input logic c,      // 1-bit input signal
    input logic d,      // 1-bit input signal
    input logic e,      // 1-bit input signal
    output logic [24:0] out // 25-bit output vector
);

always @(*) begin
    out[0]  = (a == a);
    out[1]  = (a == b);
    out[2]  = (a == c);
    out[3]  = (a == d);
    out[4]  = (a == e);
    out[5]  = (b == b);
    out[6]  = (b == c);
    out[7]  = (b == d);
    out[8]  = (b == e);
    out[9]  = (c == c);
    out[10] = (c == d);
    out[11] = (c == e);
    out[12] = (d == d);
    out[13] = (d == e);
    out[14] = (e == e);
end

endmodule