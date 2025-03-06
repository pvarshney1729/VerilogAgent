module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000: out = 1'b0; // cd = 00, ab = 00
        4'b0001: out = 1'b1; // cd = 00, ab = 01
        4'b0011: out = 1'b0; // cd = 00, ab = 11
        4'b0010: out = 1'b1; // cd = 00, ab = 10
        4'b0100: out = 1'b1; // cd = 01, ab = 00
        4'b0101: out = 1'b0; // cd = 01, ab = 01
        4'b0111: out = 1'b1; // cd = 01, ab = 11
        4'b0110: out = 1'b0; // cd = 01, ab = 10
        4'b1000: out = 1'b0; // cd = 11, ab = 00
        4'b1001: out = 1'b1; // cd = 11, ab = 01
        4'b1011: out = 1'b0; // cd = 11, ab = 11
        4'b1010: out = 1'b1; // cd = 11, ab = 10
        4'b1100: out = 1'b1; // cd = 10, ab = 00
        4'b1101: out = 1'b0; // cd = 10, ab = 01
        4'b1111: out = 1'b1; // cd = 10, ab = 11
        4'b1110: out = 1'b0; // cd = 10, ab = 10
        default: out = 1'b0; // Default case
    endcase
end

endmodule