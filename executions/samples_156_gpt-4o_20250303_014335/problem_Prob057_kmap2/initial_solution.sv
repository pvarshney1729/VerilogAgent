module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    assign out = (~c & ~d) | (c & ~d) | (~c & d) | (c & d) | ((c | d) & (~b | a));

endmodule