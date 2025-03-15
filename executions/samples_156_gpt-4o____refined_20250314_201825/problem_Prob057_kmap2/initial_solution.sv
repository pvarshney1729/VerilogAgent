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
            4'b0000, 4'b0001, 4'b0011, 4'b0100, 
            4'b0110, 4'b1000, 4'b1011, 4'b1101, 
            4'b1110, 4'b1111: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
[DONE]