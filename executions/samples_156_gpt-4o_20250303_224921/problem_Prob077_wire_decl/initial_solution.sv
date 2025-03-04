module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);
    logic and1_result;
    logic and2_result;

    assign and1_result = a & b; // First AND gate
    assign and2_result = c & d; // Second AND gate
    assign out = and1_result | and2_result; // OR gate
    assign out_n = ~out; // NOT gate for inversion

endmodule