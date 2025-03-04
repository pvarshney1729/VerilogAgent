module TopModule (
    input logic [3:0] x,   // 4-bit input operand
    input logic [3:0] y,   // 4-bit input operand
    output logic [4:0] sum // 5-bit output to accommodate overflow
);

    always @(*) begin
        sum = x + y;
    end

endmodule