module TopModule (
    input logic signed [7:0] a,
    input logic signed [7:0] b,
    output logic signed [7:0] sum,
    output logic overflow
);

    always @(*) begin
        logic signed [8:0] extended_sum;
        extended_sum = a + b;
        sum = extended_sum[7:0];
        overflow = (a[7] == b[7]) && (sum[7] != a[7]);
    end

endmodule