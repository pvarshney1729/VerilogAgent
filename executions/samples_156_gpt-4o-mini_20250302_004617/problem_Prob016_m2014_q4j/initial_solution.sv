module TopModule (
    input logic [3:0] A,
    input logic [3:0] B,
    output logic [4:0] sum,
    output logic overflow
);

    assign sum = A + B;
    assign overflow = (sum[4] ^ sum[3]) & (A[3] ^ B[3]);

endmodule