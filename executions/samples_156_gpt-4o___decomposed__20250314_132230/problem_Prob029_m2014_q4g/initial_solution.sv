module TopModule(
    input  logic in1,
    input  logic in2,
    input  logic in3,
    output logic out
);

    logic xnor_out;

    // XNOR gate logic
    assign xnor_out = ~(in1 ^ in2);

    // XOR gate logic
    assign out = xnor_out ^ in3;

endmodule