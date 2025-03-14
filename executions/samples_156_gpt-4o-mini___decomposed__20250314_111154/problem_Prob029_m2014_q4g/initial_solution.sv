module TopModule (
    input logic in1,
    input logic in2,
    input logic in3,
    output logic out
);
    logic xnor_out;
    logic xor_out;

    assign xnor_out = ~(in1 ^ in2); // Two-input XNOR
    assign xor_out = xnor_out ^ in3; // Two-input XOR
    assign out = xor_out; // Connect the output of the XOR to the output port out

endmodule