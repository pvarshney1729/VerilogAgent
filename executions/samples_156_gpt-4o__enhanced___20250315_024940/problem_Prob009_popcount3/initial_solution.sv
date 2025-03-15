module TopModule (
    input  logic [2:0] in,  // 3-bit input
    output logic [1:0] out  // 2-bit output
);

    // Combinational logic to calculate the population count
    always @(*) begin
        case (in)
            3'b000: out = 2'b00;  // 0 ones
            3'b001: out = 2'b01;  // 1 one
            3'b010: out = 2'b01;  // 1 one
            3'b011: out = 2'b10;  // 2 ones
            3'b100: out = 2'b01;  // 1 one
            3'b101: out = 2'b10;  // 2 ones
            3'b110: out = 2'b10;  // 2 ones
            3'b111: out = 2'b11;  // 3 ones
            default: out = 2'b00;  // Should not occur, but keeping it safe
        endcase
    end

endmodule