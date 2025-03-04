module TopModule(
    input logic [2:0] in_vector,
    output logic [1:0] out_count
);

always @(*) begin
    case (in_vector)
        3'b000: out_count = 2'b00;
        3'b001, 3'b010, 3'b100: out_count = 2'b01;
        3'b011, 3'b101, 3'b110: out_count = 2'b10;
        3'b111: out_count = 2'b11;
        default: out_count = 2'b00; // Default case for completeness
    endcase
end

endmodule