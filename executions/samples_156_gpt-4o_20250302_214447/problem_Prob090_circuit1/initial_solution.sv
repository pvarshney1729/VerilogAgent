module TopModule (
    input logic a,
    input logic b,
    output logic q
);
    // Combinational logic output
    assign q = a & b;
endmodule