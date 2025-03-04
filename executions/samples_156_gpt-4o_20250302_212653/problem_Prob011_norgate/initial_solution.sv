module TopModule (
    input logic a,  // 1-bit unsigned input
    input logic b,  // 1-bit unsigned input
    output logic out // 1-bit unsigned output
);

    // Implementing NOR gate logic
    assign out = ~(a | b);

endmodule