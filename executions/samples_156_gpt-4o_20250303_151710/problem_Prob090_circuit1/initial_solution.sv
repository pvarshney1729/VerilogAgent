module TopModule (
    input logic a,  // 1-bit unsigned input
    input logic b,  // 1-bit unsigned input
    output logic q  // 1-bit unsigned output
);

    // Combinational logic for AND operation
    assign q = a & b;

endmodule