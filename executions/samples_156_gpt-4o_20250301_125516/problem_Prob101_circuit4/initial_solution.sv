module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

    // Combinational logic for output q
    assign q = c | b;

endmodule