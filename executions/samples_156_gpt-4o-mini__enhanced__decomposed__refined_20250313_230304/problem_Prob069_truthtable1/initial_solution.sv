[BEGIN]
module TopModule (
    input logic x3,
    input logic x2,
    input logic x1,
    output logic f
);

always @(*) begin
    f = (1'b0 & ~x3 & x2 & ~x1) | (1'b0 & ~x3 & x2 & x1) | (1'b0 & ~x3 & ~x2 & x1) | (1'b1 & x3 & x2 & ~x1);
end

endmodule
[DONE]