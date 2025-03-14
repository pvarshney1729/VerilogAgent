module TopModule (
    input  logic [3:0] in,  // 4-bit input vector. Bit[0] is the LSB and Bit[3] is the MSB.
    output logic [1:0] pos  // 2-bit output representing the position of the first '1' bit. 
);

always @* begin
    case (in)
        4'b0000: pos = 2'b00; // No bits are high
        4'b0001: pos = 2'b00; // First bit (LSB) is high
        4'b0010: pos = 2'b01; // Second bit is high
        4'b0100: pos = 2'b10; // Third bit is high
        4'b1000: pos = 2'b11; // Fourth bit (MSB) is high
        default: pos = 2'b00; // Default case, should not occur for valid input
    endcase
end

endmodule