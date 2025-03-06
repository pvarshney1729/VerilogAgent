module TopModule (
    input wire [7:0] in,  // 8-bit input vector
    output reg [2:0] pos  // 3-bit output representing position
);

    always @(*) begin
        casez (in)
            8'b???????1: pos = 3'd0;
            8'b??????10: pos = 3'd1;
            8'b?????100: pos = 3'd2;
            8'b????1000: pos = 3'd3;
            8'b???10000: pos = 3'd4;
            8'b??100000: pos = 3'd5;
            8'b?1000000: pos = 3'd6;
            8'b10000000: pos = 3'd7;
            default:     pos = 3'd0;
        endcase
    end

endmodule