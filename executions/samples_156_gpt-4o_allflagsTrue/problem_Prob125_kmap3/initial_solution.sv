module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    // Combinational logic for the output based on the simplified expression
    assign out = (~c & a) | (c & b);

endmodule