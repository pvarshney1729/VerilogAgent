module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);

    logic and1;
    logic and2;

    assign and1 = a & b;
    assign and2 = c & d;
    assign out = and1 | and2;
    assign out_n = ~out;

endmodule