module TopModule (
    input logic a,
    input logic b,
    output logic q
);
    // Combinational logic implementation
    assign q = a & b;
endmodule