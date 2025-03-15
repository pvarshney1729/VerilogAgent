module TopModule (
    input logic [3:0] in,
    input logic clk,
    input logic reset,
    output logic [1:0] pos
);

always @(*) begin
    if (reset) begin
        pos = 2'b00;
    end else begin
        case (in)
            4'b0000: pos = 2'b00; // No high bit
            4'b0001: pos = 2'b00; // First high bit at position 0
            4'b0010: pos = 2'b01; // First high bit at position 1
            4'b0100: pos = 2'b10; // First high bit at position 2
            4'b1000: pos = 2'b11; // First high bit at position 3
            4'b0011: pos = 2'b00; // First high bit at position 0
            4'b0110: pos = 2'b01; // First high bit at position 1
            4'b1100: pos = 2'b10; // First high bit at position 2
            4'b0111: pos = 2'b00; // First high bit at position 0
            4'b1110: pos = 2'b01; // First high bit at position 1
            4'b1111: pos = 2'b00; // First high bit at position 0
            default: pos = 2'b00; // Default case
        endcase
    end
end

endmodule