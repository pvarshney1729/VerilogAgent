module TopModule (
    input logic [7:0] in_vector,
    output logic [2:0] pos
);

always @(*) begin
    case (in_vector)
        8'b00000000: pos = 3'b000;
        8'b00000001: pos = 3'b000;
        8'b00000010: pos = 3'b001;
        8'b00000100: pos = 3'b010;
        8'b00001000: pos = 3'b011;
        8'b00010000: pos = 3'b100;
        8'b00100000: pos = 3'b101;
        8'b01000000: pos = 3'b110;
        8'b10000000: pos = 3'b111;
        default: pos = 3'b000; // This handles cases with multiple bits set
    endcase
end

endmodule