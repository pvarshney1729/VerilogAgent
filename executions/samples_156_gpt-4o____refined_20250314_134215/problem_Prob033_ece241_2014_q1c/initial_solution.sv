[BEGIN]
module TopModule (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);

    always @(*) begin
        logic [8:0] sum;
        sum = a + b;
        s = sum[7:0];
        overflow = (a[7] == b[7]) && (s[7] != a[7]) ? 1'b1 : 1'b0;
    end

endmodule
[DONE]