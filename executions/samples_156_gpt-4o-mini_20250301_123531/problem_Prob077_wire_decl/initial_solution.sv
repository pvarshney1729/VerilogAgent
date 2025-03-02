module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);

    logic and1_output;
    logic and2_output;

    assign and1_output = a & b;
    assign and2_output = c & d;
    assign out = and1_output | and2_output;
    assign out_n = ~out;

endmodule