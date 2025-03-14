module TopModule (
    input  logic [3:0] x,      // 4-bit input x
    input  logic [3:0] y,      // 4-bit input y
    output logic [4:0] sum     // 5-bit output sum
);

    always @(*) begin
        {sum[4], sum[3:0]} = x + y; // Perform addition and capture overflow
    end

endmodule