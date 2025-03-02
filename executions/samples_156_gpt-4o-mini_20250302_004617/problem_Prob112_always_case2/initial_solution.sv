module priority_encoder (
    input logic [3:0] in,
    output logic [1:0] out
);
    always @(*) begin
        case (in)
            4'b0000: out = 2'b00; // No high bits
            4'b0001: out = 2'b00; // First high bit at position 0
            4'b0010: out = 2'b01; // First high bit at position 1
            4'b0011: out = 2'b01; // First high bit at position 1
            4'b0100: out = 2'b10; // First high bit at position 2
            4'b0101: out = 2'b10; // First high bit at position 2
            4'b0110: out = 2'b10; // First high bit at position 2
            4'b0111: out = 2'b10; // First high bit at position 2
            4'b1000: out = 2'b11; // First high bit at position 3
            4'b1001: out = 2'b11; // First high bit at position 3
            4'b1010: out = 2'b11; // First high bit at position 3
            4'b1011: out = 2'b11; // First high bit at position 3
            4'b1100: out = 2'b11; // First high bit at position 3
            4'b1101: out = 2'b11; // First high bit at position 3
            4'b1110: out = 2'b11; // First high bit at position 3
            4'b1111: out = 2'b11; // First high bit at position 3
            default: out = 2'b00; // Default case
        endcase
    end
endmodule