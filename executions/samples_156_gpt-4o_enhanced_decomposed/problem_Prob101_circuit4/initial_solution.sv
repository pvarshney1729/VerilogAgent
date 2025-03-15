module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);
    // Implement the logic derived from the truth table
    assign q = c | b;
endmodule