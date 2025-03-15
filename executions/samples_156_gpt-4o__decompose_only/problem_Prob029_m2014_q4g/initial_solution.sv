module TopModule (
    input  logic in1,
    input  logic in2,
    input  logic in3,
    output logic out
);

    logic xnor_out;

    // Two-input XNOR gate
    assign xnor_out = ~(in1 ^ in2);

    // Two-input XOR gate
    assign out = xnor_out ^ in3;

endmodule