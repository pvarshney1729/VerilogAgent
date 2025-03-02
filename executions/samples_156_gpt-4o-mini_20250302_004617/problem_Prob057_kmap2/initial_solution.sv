module TopModule (
    input logic a,
    input logic b,
    input logic c,
    output logic y
);

    // Combinational logic derived from the Boolean expression
    assign y = (a & b) | (~a & c);

endmodule