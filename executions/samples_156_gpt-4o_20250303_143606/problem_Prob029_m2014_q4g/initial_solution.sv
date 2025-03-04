module TopModule (
    input wire in1,  // 1-bit input
    input wire in2,  // 1-bit input
    input wire in3,  // 1-bit input
    output wire out  // 1-bit output
);

    // Intermediate signal for XNOR operation
    wire xnor_out;

    // XNOR operation
    assign xnor_out = ~(in1 ^ in2);

    // XOR operation
    assign out = xnor_out ^ in3;

endmodule