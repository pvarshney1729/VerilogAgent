module TopModule (
    input logic [3:0] in,  // 4-bit input
    output logic [1:0] pos // 2-bit output
);

    always @(*) begin
        case (in)
            4'b0000: pos = 2'b00; // No bits high
            4'b0001: pos = 2'b00; // Bit 0 is high
            4'b0010: pos = 2'b01; // Bit 1 is high
            4'b0100: pos = 2'b10; // Bit 2 is high
            4'b1000: pos = 2'b11; // Bit 3 is high
            4'b0011: pos = 2'b01; // Bits 0 and 1 are high, first is 1
            4'b0110: pos = 2'b01; // Bits 1 and 2 are high, first is 1
            4'b1100: pos = 2'b11; // Bits 2 and 3 are high, first is 1
            4'b0101: pos = 2'b10; // Bits 0 and 2 are high, first is 1
            4'b1001: pos = 2'b11; // Bits 0 and 3 are high, first is 1
            4'b1010: pos = 2'b11; // Bits 1 and 3 are high, first is 1
            4'b1101: pos = 2'b11; // Bits 0, 2 and 3 are high, first is 1
            4'b1110: pos = 2'b11; // Bits 1, 2 and 3 are high, first is 1
            4'b1111: pos = 2'b11; // All bits high, first is 1
            default: pos = 2'b00; // Default case (should not occur)
        endcase
    end

endmodule