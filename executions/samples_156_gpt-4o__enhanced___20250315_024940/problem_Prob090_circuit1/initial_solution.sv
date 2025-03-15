module TopModule (
    input logic a,
    input logic b,
    output logic q
);

    // Combinational logic to determine output q based on inputs a and b
    assign q = a & b;  // q is high only when both a and b are high

endmodule