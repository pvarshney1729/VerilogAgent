module TopModule (
    input wire in1,  // Single-bit input, unsigned
    input wire in2,  // Single-bit input, unsigned
    output wire out  // Single-bit output, unsigned
);

    // Combinational logic for 2-input NOR gate
    assign out = ~(in1 | in2);

endmodule