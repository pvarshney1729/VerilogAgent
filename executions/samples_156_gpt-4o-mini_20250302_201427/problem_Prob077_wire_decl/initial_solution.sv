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

    assign and1_result = a & b;
    assign and2_result = c & d;
    assign out = and1_result | and2_result;
    assign out_n = ~out;

endmodule