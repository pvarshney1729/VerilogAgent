module TopModule (
    input wire in1,
    input wire in2,
    input wire in3,
    output wire out
);

    // Intermediate wire for XNOR result
    wire xnor_result;

    // XNOR operation
    assign xnor_result = ~(in1 ^ in2);

    // XOR operation
    assign out = xnor_result ^ in3;

endmodule