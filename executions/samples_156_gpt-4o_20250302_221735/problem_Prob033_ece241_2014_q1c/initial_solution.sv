module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] s,
    output logic overflow_flag
);

    logic [8:0] sum_extended;

    always @(*) begin
        sum_extended = a + b;
        s = sum_extended[7:0];
        overflow_flag = (a[7] == b[7]) && (s[7] != a[7]);
    end

endmodule