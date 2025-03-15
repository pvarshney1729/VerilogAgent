module TopModule (
    input logic [3:0] in,  // 4-bit input
    output logic out_and,   // Output of 4-input AND gate
    output logic out_or,    // Output of 4-input OR gate
    output logic out_xor    // Output of 4-input XOR gate
);

    // Combinational logic for outputs
    always @(*) begin
        out_and = in[0] & in[1] & in[2] & in[3];  // AND operation
        out_or  = in[0] | in[1] | in[2] | in[3];  // OR operation
        out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];  // XOR operation
    end

endmodule