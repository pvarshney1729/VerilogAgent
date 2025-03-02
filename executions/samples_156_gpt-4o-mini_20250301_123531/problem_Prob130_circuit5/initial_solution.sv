module TopModule (
    input logic [3:0] a, // 4-bit input vector
    input logic [3:0] b, // 4-bit input vector
    input logic [3:0] c, // 4-bit input vector
    input logic [3:0] d, // 4-bit input vector
    input logic [3:0] e, // 4-bit input vector
    output logic [3:0] q  // 4-bit output vector
);

always @(*) begin
    case (c)
        4'b0000: q = b; // c = 0
        4'b0001: q = e; // c = 1
        4'b0010: q = a; // c = 2
        4'b0011: q = d; // c = 3
        default: q = 4'hf; // c = 4 to f
    endcase
end

endmodule