module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

    always @(*) begin
        case ({a, b, c, d})
            4'b0000: q = 1;
            4'b0001: q = 0;
            4'b0010: q = 0;
            4'b0011: q = 1;
            4'b0100: q = 0;
            4'b0101: q = 1;
            4'b0110: q = 1;
            4'b0111: q = 0;
            4'b1000: q = 0;
            4'b1001: q = 1;
            4'b1010: q = 1;
            4'b1011: q = 0;
            4'b1100: q = 1;
            4'b1101: q = 0;
            4'b1110: q = 0;
            4'b1111: q = 1;
            default: q = 0; // default case for completeness
        endcase
    end

endmodule