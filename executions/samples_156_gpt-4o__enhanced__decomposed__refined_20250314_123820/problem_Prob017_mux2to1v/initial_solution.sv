[BEGIN]
module TopModule (
    input  logic [99:0] a,   // 100-bit input, unsigned
    input  logic [99:0] b,   // 100-bit input, unsigned
    input  logic        sel, // 1-bit select signal
    output logic [99:0] out  // 100-bit output, unsigned
);

    always @(*) begin
        case (sel)
            1'b0: out = a;
            1'b1: out = b;
            default: out = 100'b0; // Default case for safety, but sel should always be 0 or 1
        endcase
    end

endmodule
[DONE]