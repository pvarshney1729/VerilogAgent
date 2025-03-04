module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    assign out = (~a & c & ~d) | (a & b) | (b & c);

endmodule