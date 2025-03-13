module TopModule (
    input  logic [2:0] in,
    output logic [1:0] out
);

    always @(*) begin
        case (in)
            3'b000: out = 2'b00;
            3'b001, 3'b010, 3'b100: out = 2'b01;
            3'b011, 3'b101, 3'b110: out = 2'b10;
            3'b111: out = 2'b11;
            default: out = 2'b00; // Default case for completeness
        endcase
    end

endmodule