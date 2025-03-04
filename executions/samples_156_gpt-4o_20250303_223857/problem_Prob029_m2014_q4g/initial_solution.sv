module TopModule(
    input wire in1,
    input wire in2,
    input wire in3,
    output wire out
);

    // Intermediate signal for XNOR operation
    wire xnor1;

    // XNOR operation
    assign xnor1 = ~(in1 ^ in2);

    // XOR operation for final output
    assign out = xnor1 ^ in3;

endmodule