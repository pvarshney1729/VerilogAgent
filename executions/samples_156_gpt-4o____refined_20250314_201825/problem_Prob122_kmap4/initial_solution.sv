[BEGIN]
module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out
);

    always @(*) begin
        case ({c, d, a, b})
            4'b0001, 4'b0011,
            4'b0100, 4'b0110,
            4'b1001, 4'b1011,
            4'b1100, 4'b1110: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
[DONE]