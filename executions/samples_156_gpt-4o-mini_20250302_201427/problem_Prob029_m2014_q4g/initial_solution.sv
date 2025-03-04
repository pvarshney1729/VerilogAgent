module TopModule (
    input logic in1, // 1-bit input
    input logic in2, // 1-bit input
    input logic in3, // 1-bit input
    output logic out  // 1-bit output
);

    logic XNOR_out;

    assign XNOR_out = ~(in1 ^ in2); // XNOR operation
    assign out = XNOR_out ^ in3;    // XOR operation

endmodule