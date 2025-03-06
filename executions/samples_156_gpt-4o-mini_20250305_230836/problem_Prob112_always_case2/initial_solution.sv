module TopModule (
    input logic [3:0] in,
    output logic [1:0] pos
);

always @(*) begin
    case (in)
        4'b1xxx: pos = 2'b11; // in[3] is high
        4'b01xx: pos = 2'b10; // in[2] is high
        4'b001x: pos = 2'b01; // in[1] is high
        4'b0001: pos = 2'b00; // in[0] is high
        default: pos = 2'b00; // all bits are low
    endcase
end

endmodule