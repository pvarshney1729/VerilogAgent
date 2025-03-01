module TopModule (
    input wire [3:0] in,   // 4-bit input vector (in[3] is MSB, in[0] is LSB)
    output reg [1:0] pos   // 2-bit output representing the position of the first high bit
);

always @(*) begin
    casez (in)
        4'b1???: pos = 2'b11;
        4'b01??: pos = 2'b10;
        4'b001?: pos = 2'b01;
        4'b0001: pos = 2'b00;
        default: pos = 2'b00;  // When in is 4'b0000
    endcase
end

endmodule