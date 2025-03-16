module TopModule (
    input logic a,
    input logic b,
    input logic cin,
    output logic cout,
    output logic sum
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule