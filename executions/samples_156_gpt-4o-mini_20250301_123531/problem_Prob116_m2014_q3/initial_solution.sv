module TopModule (
    input logic [3:0] x,
    output logic f
);

always @(*) begin
    case ({x[3], x[2]})
        2'b00: f = 1'b0; // Don't care
        2'b01: f = (x[1] == 1'b1) ? 1'b1 : 1'b0; // 1 for x[1]x[2] = 11
        2'b11: f = 1'b1; // 1 for x[1]x[2] = 00, 01
        2'b10: f = (x[1] == 1'b0) ? 1'b1 : 1'b0; // 1 for x[1]x[2] = 00, 01
        default: f = 1'b0; // Default case
    endcase
end

endmodule