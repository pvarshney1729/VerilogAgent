module combinational_logic (
    input logic A,
    input logic B,
    input logic C,
    output logic F
);

always @(*) begin
    case ({A, B, C})
        3'b000: F = 1'b0;
        3'b001: F = 1'b1;
        3'b010: F = 1'b1;
        3'b011: F = 1'b0;
        3'b100: F = 1'b1;
        3'b101: F = 1'b0;
        3'b110: F = 1'b0;
        3'b111: F = 1'b1;
        default: F = 1'b0;
    endcase
end

endmodule