module TopModule(
    input logic in1,  // Single-bit input, represents the first operand for XNOR.
    input logic in2,  // Single-bit input, represents the second operand for XNOR.
    input logic in3,  // Single-bit input, represents the second operand for XOR.
    output logic out  // Single-bit output, result of the XOR operation.
);

    logic xnor_out;

    always @(*) begin
        xnor_out = ~(in1 ^ in2);  // XNOR operation
        out = xnor_out ^ in3;     // XOR operation
    end

endmodule