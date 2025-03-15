module TopModule(
    input  logic [3:0] in,
    output logic [1:0] pos
);

    always @(*) begin
        case (in)
            4'b0001: pos = 2'b00; // LSB is high
            4'b0010: pos = 2'b01; // Bit 1 is high
            4'b0100: pos = 2'b10; // Bit 2 is high
            4'b1000: pos = 2'b11; // MSB is high
            default: pos = 2'b00; // No bits are high or multiple bits are high
        endcase
    end
    
endmodule