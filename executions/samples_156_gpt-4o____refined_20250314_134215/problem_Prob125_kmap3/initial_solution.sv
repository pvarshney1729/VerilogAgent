module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out
);

    always @(*) begin
        case ({c, b, a})
            3'b000: out = 1'b0;
            3'b001: out = 1'b0;
            3'b010: out = 1'b1;
            3'b011: out = 1'b1;
            3'b100: out = 1'b1;
            3'b101: out = 1'b1;
            3'b110: out = 1'b1;
            3'b111: out = 1'b1;
            default: out = 1'b0; // Handle don't-care and undefined cases
        endcase
    end

endmodule