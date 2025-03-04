module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        case ({c, d, a, b})
            4'b0000: out = 1'b0; // c=0, d=0, ab=00
            4'b0001: out = 1'b1; // c=0, d=0, ab=01
            4'b0010: out = 1'b1; // c=0, d=0, ab=10
            4'b0011: out = 1'b1; // c=0, d=0, ab=11
            4'b0100: out = 1'b0; // c=0, d=1, ab=00
            4'b0101: out = 1'b0; // c=0, d=1, ab=01
            4'b0110: out = 1'b1; // c=0, d=1, ab=10
            4'b0111: out = 1'b1; // c=0, d=1, ab=11
            4'b1000: out = 1'b0; // c=1, d=0, ab=00
            4'b1001: out = 1'b0; // c=1, d=0, ab=01
            4'b1010: out = 1'b1; // c=1, d=0, ab=10
            4'b1011: out = 1'b1; // c=1, d=0, ab=11
            4'b1100: out = 1'b0; // c=1, d=1, ab=00
            4'b1101: out = 1'b1; // c=1, d=1, ab=01
            4'b1110: out = 1'b1; // c=1, d=1, ab=10
            4'b1111: out = 1'b1; // c=1, d=1, ab=11
            default: out = 1'b0; // Default case
        endcase
    end

endmodule