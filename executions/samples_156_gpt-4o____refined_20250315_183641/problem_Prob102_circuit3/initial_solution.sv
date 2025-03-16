[BEGIN]
module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic q
);

    always @(*) begin
        q = (b & d) | (b & c) | (a & d) | (a & c);
    end

endmodule
[DONE]