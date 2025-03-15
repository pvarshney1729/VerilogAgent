module TopModule (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic cout
);

    // XOR operation for sum
    assign sum = a ^ b;

    // AND operation for carry-out
    assign cout = a & b;

endmodule