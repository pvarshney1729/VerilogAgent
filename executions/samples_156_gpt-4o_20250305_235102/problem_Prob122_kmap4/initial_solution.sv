module TopModule(
    input logic a, // 1-bit, unsigned
    input logic b, // 1-bit, unsigned
    input logic c, // 1-bit, unsigned
    input logic d, // 1-bit, unsigned
    output logic out // 1-bit, unsigned
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000: out = 0;
        4'b0001: out = 1;
        4'b0011: out = 0;
        4'b0010: out = 1;
        4'b0100: out = 1;
        4'b0101: out = 0;
        4'b0111: out = 1;
        4'b0110: out = 0;
        4'b1100: out = 0;
        4'b1101: out = 1;
        4'b1111: out = 0;
        4'b1110: out = 1;
        4'b1000: out = 1;
        4'b1001: out = 0;
        4'b1011: out = 1;
        4'b1010: out = 0;
        default: out = 0; // Default case for completeness
    endcase
end

endmodule