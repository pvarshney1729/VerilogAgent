```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);

    always @(*) begin
        out[24] = (a == a); // = 1'b1
        out[23] = (a == b);
        out[22] = (a == c);
        out[21] = (a == d);
        out[20] = (a == e);

        out[19] = (b == a);
        out[18] = (b == b); // = 1'b1
        out[17] = (b == c);
        out[16] = (b == d);
        out[15] = (b == e);

        out[14] = (c == a);
        out[13] = (c == b);
        out[12] = (c == c); // = 1'b1
        out[11] = (c == d);
        out[10] = (c == e);

        out[9]  = (d == a);
        out[8]  = (d == b);
        out[7]  = (d == c);
        out[6]  = (d == d); // = 1'b1
        out[5]  = (d == e);

        out[4]  = (e == a);
        out[3]  = (e == b);
        out[2]  = (e == c);
        out[1]  = (e == d);
        out[0]  = (e == e); // = 1'b1
    end

endmodule
```