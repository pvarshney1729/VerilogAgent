module TopModule (
    input logic [3:0] a, // 4-bit unsigned input
    input logic [3:0] b, // 4-bit unsigned input
    input logic [3:0] c, // 4-bit unsigned input
    input logic [3:0] d, // 4-bit unsigned input
    input logic [3:0] e, // 4-bit unsigned input
    output logic [3:0] q // 4-bit unsigned output
);

always @(*) begin
    case (c)
        4'd0: q = b;
        4'd1: q = e;
        4'd2: q = a;
        4'd3: q = d;
        default: q = 4'b1111; // Covers cases 4 to 9 and beyond
    endcase
end

endmodule