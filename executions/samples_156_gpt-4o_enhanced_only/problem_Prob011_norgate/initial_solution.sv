module TopModule(
    input logic a,
    input logic b,
    output logic out
);

    // Combinational logic for NOR gate
    assign out = ~(a | b);

endmodule