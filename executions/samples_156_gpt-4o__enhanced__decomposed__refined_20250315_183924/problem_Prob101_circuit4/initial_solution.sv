[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

    always @(*) begin
        q = (b & !a) | (c & !d & !a) | (d & c);
    end

endmodule
[DONE]