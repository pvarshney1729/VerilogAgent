module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        case ({c, d, b, a})
            4'b0000: out = 1'b0; // Don't care
            4'b0001: out = 1'b0; // 0
            4'b0010: out = 1'b1; // 1
            4'b0011: out = 1'b1; // 1
            4'b0100: out = 1'b0; // 0
            4'b0101: out = 1'b0; // 0
            4'b0110: out = 1'b1; // Don't care
            4'b0111: out = 1'b1; // Don't care
            4'b1000: out = 1'b0; // 0
            4'b1001: out = 1'b1; // 1
            4'b1010: out = 1'b1; // 1
            4'b1011: out = 1'b1; // 1
            4'b1100: out = 1'b0; // 0
            4'b1101: out = 1'b1; // 1
            4'b1110: out = 1'b1; // 1
            4'b1111: out = 1'b1; // 1
            default: out = 1'b0; // Default case
        endcase
    end

endmodule