module TopModule (
    input  wire [2:0] a,  // 3-bit input, representing values 0 to 7
    output reg  [15:0] q  // 16-bit output, unsigned
);

always @(*) begin
    case (a)
        3'b000: q = 16'h1232;
        3'b001: q = 16'haee0;
        3'b010: q = 16'h27d4;
        3'b011: q = 16'h5a0e;
        3'b100: q = 16'h2066;
        3'b101: q = 16'h64ce;
        3'b110: q = 16'hc526;
        3'b111: q = 16'h2f19;
        default: q = 16'h0000;  // Default case for undefined inputs
    endcase
end

endmodule