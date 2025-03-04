module TopModule (
    input wire in1,       // Single-bit input signal
    input wire in2,       // Single-bit input signal
    input wire in3,       // Single-bit input signal
    output wire out       // Single-bit output signal
);

    // Combinational logic implementation
    assign out = ~((in1 ^ in2) ^ in3);

endmodule