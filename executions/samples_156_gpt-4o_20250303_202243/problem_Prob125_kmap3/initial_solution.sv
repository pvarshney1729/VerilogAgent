module TopModule(
    input logic a,  // Single-bit, unsigned
    input logic b,  // Single-bit, unsigned
    input logic c,  // Single-bit, unsigned
    input logic d,  // Single-bit, unsigned
    output logic out // Single-bit, unsigned
);

    always @(*) begin
        case ({c, d, a, b})
            4'b0000: out = 0;
            4'b0001: out = 'X; // Don't-care condition
            4'b0010: out = 1;
            4'b0011: out = 1;
            4'b0100: out = 0;
            4'b0101: out = 0;
            4'b0110: out = 'X; // Don't-care condition
            4'b0111: out = 'X; // Don't-care condition
            4'b1000: out = 0;
            4'b1001: out = 1;
            4'b1010: out = 1;
            4'b1011: out = 1;
            4'b1100: out = 0;
            4'b1101: out = 1;
            4'b1110: out = 1;
            4'b1111: out = 1;
            default: out = 0; // Default case for safety
        endcase
    end

endmodule