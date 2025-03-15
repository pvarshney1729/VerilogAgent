module TopModule(
    input logic a,
    input logic b,
    output logic out
);
    // Implementing NOR gate using assign statement
    assign out = ~(a | b);
endmodule