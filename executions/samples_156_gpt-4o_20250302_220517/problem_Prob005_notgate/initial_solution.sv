module TopModule (
    input logic in,     // Single-bit input
    output logic out    // Single-bit output
);
    // Combinational logic for NOT gate
    assign out = ~in;
endmodule