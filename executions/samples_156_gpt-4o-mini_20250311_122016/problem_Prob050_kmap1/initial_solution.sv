module TopModule (
    input logic a,
    input logic b,
    input logic c,
    output logic out
);

    assign out = (b & c) | (a & (b | c));

endmodule