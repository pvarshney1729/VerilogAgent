module TopModule (
    input  logic [3:0] a, // 4-bit input
    input  logic [3:0] b, // 4-bit input
    input  logic [3:0] c, // 4-bit input
    input  logic [3:0] d, // 4-bit input
    input  logic [3:0] e, // 4-bit input
    output logic [3:0] q  // 4-bit output
);

always @(*) begin
    case (c)
        4'b0000: q = b;
        4'b0001: q = e;
        4'b0010: q = a;
        4'b0011: q = d;
        default: q = 4'b1111; // Covers c = 4 to 15
    endcase
end

endmodule