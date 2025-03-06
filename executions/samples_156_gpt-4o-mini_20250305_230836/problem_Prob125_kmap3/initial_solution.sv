module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

always @(*) begin
    case ({c, d, a, b})
        4'b00_00: out = 1'b0;  // ab = 00
        4'b00_01: out = 1'b0;  // ab = 01
        4'b00_10: out = 1'b1;  // ab = 10
        4'b00_11: out = 1'b1;  // ab = 11
        4'b01_00: out = 1'b1;  // ab = 00
        4'b01_01: out = 1'b0;  // ab = 01
        4'b01_10: out = 1'b1;  // ab = 10
        4'b01_11: out = 1'b1;  // ab = 11
        4'b10_00: out = 1'b1;  // ab = 00
        4'b10_01: out = 1'b0;  // ab = 01
        4'b10_10: out = 1'b1;  // ab = 10
        4'b10_11: out = 1'b1;  // ab = 11
        4'b11_00: out = 1'b1;  // ab = 00
        4'b11_01: out = 1'b0;  // ab = 01
        4'b11_10: out = 1'b1;  // ab = 10
        4'b11_11: out = 1'b1;  // ab = 11
        default: out = 1'b0;    // Default case
    endcase
end

endmodule