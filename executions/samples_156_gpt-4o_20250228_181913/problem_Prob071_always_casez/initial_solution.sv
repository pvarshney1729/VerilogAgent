```verilog
module TopModule (
    input wire [7:0] in,  // 8-bit input vector
    output reg [2:0] pos  // 3-bit output representing the position of the first high bit
);

always @(*) begin
    casez (in)
        8'b????_???1: pos = 3'd0;
        8'b????_??10: pos = 3'd1;
        8'b????_?100: pos = 3'd2;
        8'b????_1000: pos = 3'd3;
        8'b???1_0000: pos = 3'd4;
        8'b??10_0000: pos = 3'd5;
        8'b?100_0000: pos = 3'd6;
        8'b1000_0000: pos = 3'd7;
        default: pos = 3'd0;  // When 'in' is zero
    endcase
end

endmodule
```