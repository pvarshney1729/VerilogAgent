module TopModule (
    input logic a,  // 1-bit wide, unsigned, primary input
    input logic b,  // 1-bit wide, unsigned, primary input
    output logic out // 1-bit wide, unsigned, output
);

    // Combinational logic for NOR gate
    assign out = ~(a | b);

endmodule