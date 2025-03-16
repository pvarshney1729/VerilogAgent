[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

always @(*) begin
    case ({c, d})
        2'b00: out = 1'b1; // ab = 00, 01, 10
        2'b01: out = (!a & !b) | (!a & b) | (a & !b);
        2'b11: out = (a & b) | (!a & b) | (a & !b);
        2'b10: out = (!a & !b) | (!a & b);
        default: out = 1'b0;
    endcase
end

endmodule
[END]