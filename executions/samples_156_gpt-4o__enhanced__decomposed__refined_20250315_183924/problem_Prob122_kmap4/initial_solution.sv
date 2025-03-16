[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);
    always @(*) begin
        out = (~c & ~d & b) | (~c & d & ~b) | (c & ~d & b) | (c & d & ~b);
    end
endmodule
[DONE]