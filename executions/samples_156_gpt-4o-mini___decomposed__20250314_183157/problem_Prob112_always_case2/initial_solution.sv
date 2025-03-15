module TopModule (
    input  logic [3:0] in,
    output logic [1:0] pos
);

always @(*) begin
    case (in)
        4'b0000: pos = 2'b00; // No bits are high
        4'b0001: pos = 2'b00; // Position 0
        4'b0010: pos = 2'b01; // Position 1
        4'b0100: pos = 2'b10; // Position 2
        4'b1000: pos = 2'b11; // Position 3
        default: pos = 2'b00; // Default case (should not occur)
    endcase
end

endmodule