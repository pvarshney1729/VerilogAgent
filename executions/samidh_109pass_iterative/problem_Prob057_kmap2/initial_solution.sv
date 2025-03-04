module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        case ({c, d})
            2'b00: out = (a == 1'b0) || (b == 1'b0) || (a == 1'b1 && b == 1'b0);
            2'b01: out = (a == 1'b0) || (b == 1'b1 && a == 1'b0);
            2'b10: out = (a == 1'b0) || (b == 1'b0);
            2'b11: out = (a == 1'b1) || (b == 1'b0);
            default: out = 1'b0; // Default case for safety
        endcase
    end

endmodule