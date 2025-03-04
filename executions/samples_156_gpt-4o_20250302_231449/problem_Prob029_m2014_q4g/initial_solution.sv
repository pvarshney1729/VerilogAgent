module TopModule (
    input logic in1,
    input logic in2,
    input logic in3,
    output logic out
);
    // Intermediate signal for XNOR output
    logic xnor_out;

    // XNOR operation
    assign xnor_out = ~(in1 ^ in2);
    
    // XOR operation
    assign out = xnor_out ^ in3;

endmodule