module TopModule (
    input  wire [3:0] a, // 4-bit unsigned input
    input  wire [3:0] b, // 4-bit unsigned input
    input  wire [3:0] c, // 4-bit unsigned input
    input  wire [3:0] d, // 4-bit unsigned input
    input  wire [3:0] e, // 4-bit unsigned input
    output reg  [3:0] q  // 4-bit unsigned output
);

    always @(*) begin
        case (c)
            4'b0000: q = b;
            4'b0001: q = e;
            4'b0010: q = a;
            4'b0011: q = d;
            default: q = 4'b1111;
        endcase
    end

endmodule