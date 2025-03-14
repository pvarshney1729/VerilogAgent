module TopModule (
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

reg [63:0] shift_reg;

always @(posedge clk) begin
    if (load) begin
        shift_reg <= data; // Load data into shift register
    end else if (ena) begin
        case (amount)
            2'b00: shift_reg <= shift_reg << 1;   // Shift left by 1 bit
            2'b01: shift_reg <= shift_reg << 8;   // Shift left by 8 bits
            2'b10: shift_reg <= {shift_reg[63], shift_reg[62:0]}; // Arithmetic right shift by 1 bit
            2'b11: shift_reg <= {shift_reg[63], shift_reg[63:8]}; // Arithmetic right shift by 8 bits
        endcase
    end
end

assign q = shift_reg; // Output the contents of the shift register

endmodule