[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    output logic out
);

    always @(*) begin
        out = ~(a | b);
    end

endmodule
[DONE]