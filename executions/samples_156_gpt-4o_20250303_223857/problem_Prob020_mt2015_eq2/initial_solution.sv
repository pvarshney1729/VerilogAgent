module TopModule(
    input [1:0] A,
    input [1:0] B,
    output reg z
);

always @(*) begin
    if (A == B)
        z = 1'b1;
    else
        z = 1'b0;
end

endmodule