module TopModule (
    input logic in1,  // 1-bit input
    input logic in2,  // 1-bit input
    input logic in3,  // 1-bit input
    output logic out  // 1-bit output
);

    always @(*) begin
        out = (in1 ~^ in2) ^ in3; // Compute XNOR of in1 and in2, then XOR with in3
    end

endmodule