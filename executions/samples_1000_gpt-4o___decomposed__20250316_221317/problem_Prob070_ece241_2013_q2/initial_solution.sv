module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    always @(*) begin
        case ({a, b, c, d})
            4'b0010: out_sop = 1;
            4'b0111: out_sop = 1;
            4'b1111: out_sop = 1;
            default: out_sop = 0;
        endcase
    end

    always @(*) begin
        case ({a, b, c, d})
            4'b0000: out_pos = 0;
            4'b0001: out_pos = 0;
            4'b0100: out_pos = 0;
            4'b0101: out_pos = 0;
            4'b0110: out_pos = 0;
            4'b1001: out_pos = 0;
            4'b1010: out_pos = 0;
            4'b1101: out_pos = 0;
            4'b1110: out_pos = 0;
            default: out_pos = 1;
        endcase
    end

endmodule