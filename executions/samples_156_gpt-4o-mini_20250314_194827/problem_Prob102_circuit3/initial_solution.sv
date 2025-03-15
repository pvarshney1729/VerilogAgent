module TopModule (
    input logic A,
    input logic B,
    input logic C,
    output logic Y
);

always @(*) begin
    Y = (A & B) | (B & ~C) | (A & ~C);
end

endmodule