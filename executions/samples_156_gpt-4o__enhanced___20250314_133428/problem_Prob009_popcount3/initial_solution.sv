module TopModule (
    input [2:0] in,   // 3-bit input vector where in[2] is the MSB and in[0] is the LSB
    output logic [1:0] out  // 2-bit output representing the population count of '1's in the input vector
);

    always @(*) begin
        case (in)
            3'b000: out = 2'b00;
            3'b001: out = 2'b01;
            3'b010: out = 2'b01;
            3'b011: out = 2'b10;
            3'b100: out = 2'b01;
            3'b101: out = 2'b10;
            3'b110: out = 2'b10;
            3'b111: out = 2'b11;
            default: out = 2'b00; // Default case for safety
        endcase
    end

endmodule