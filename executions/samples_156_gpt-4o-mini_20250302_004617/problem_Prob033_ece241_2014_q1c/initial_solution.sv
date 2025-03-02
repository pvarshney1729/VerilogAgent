module TopModule (
    input logic [7:0] A,
    input logic [7:0] B,
    output logic [7:0] Sum,
    output logic Overflow
);

    logic [8:0] full_sum;

    // Calculate the full sum including carry
    assign full_sum = {1'b0, A} + {1'b0, B};

    // Assign the sum output
    assign Sum = full_sum[7:0];

    // Detect overflow: overflow occurs if the sign of A and B are the same
    // and the sign of the result is different
    assign Overflow = (A[7] == B[7]) && (A[7] != Sum[7]);

endmodule