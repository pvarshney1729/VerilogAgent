[BEGIN]
module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);
    always @(*) begin
        out = ~({1'b0, in1} | {1'b0, in2});
    end
endmodule
[DONE]