module TopModule (
    input logic [3:0] in,
    output logic [1:0] pos
);

always @(*) begin
    case (in)
        4'b0000: pos = 2'b00; // No bits are high
        4'b0001: pos = 2'b00; // First bit
        4'b0010: pos = 2'b01; // Second bit
        4'b0011: pos = 2'b01; // Second bit
        4'b0100: pos = 2'b10; // Third bit
        4'b0101: pos = 2'b10; // Third bit
        4'b0110: pos = 2'b10; // Third bit
        4'b0111: pos = 2'b10; // Third bit
        4'b1000: pos = 2'b11; // Fourth bit
        4'b1001: pos = 2'b11; // Fourth bit
        4'b1010: pos = 2'b11; // Fourth bit
        4'b1011: pos = 2'b11; // Fourth bit
        4'b1100: pos = 2'b11; // Fourth bit
        4'b1101: pos = 2'b11; // Fourth bit
        4'b1110: pos = 2'b11; // Fourth bit
        4'b1111: pos = 2'b11; // Fourth bit
        default: pos = 2'b00; // Default case
    endcase
end

endmodule