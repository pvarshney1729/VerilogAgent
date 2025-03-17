module TopModule(
    input  logic a,
    input  logic b,
    output logic out
);

    // Implementing the NOR gate logic
    assign out = ~(a | b);

endmodule