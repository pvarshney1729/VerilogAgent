module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

    assign q = (b & d) | (a & c) | (a & d);

endmodule