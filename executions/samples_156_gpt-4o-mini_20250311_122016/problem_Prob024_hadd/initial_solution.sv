module TopModule (
    input logic a,
    input logic b,
    output logic sum,
    output logic cout
);

    assign sum = a ^ b;  // XOR gate for sum
    assign cout = a & b; // AND gate for carry-out

endmodule