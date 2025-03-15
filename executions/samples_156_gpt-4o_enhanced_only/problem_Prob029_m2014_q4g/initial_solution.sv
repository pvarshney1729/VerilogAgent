module TopModule(
    input logic in1,
    input logic in2,
    input logic in3,
    output logic out
);

    logic xnor_out;

    // XNOR operation between in1 and in2
    assign xnor_out = ~(in1 ^ in2);

    // XOR operation between xnor_out and in3
    assign out = xnor_out ^ in3;

endmodule