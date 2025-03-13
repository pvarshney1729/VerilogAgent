[BEGIN]
module TopModule (
    input logic [3:0] in,       // 4-bit input (in[3] - MSB, in[0] - LSB, unsigned)
    output logic out_and,       // 1-bit output for 4-input AND
    output logic out_or,        // 1-bit output for 4-input OR
    output logic out_xor        // 1-bit output for 4-input XOR
);

always @(*) begin
    out_and = in[3] & in[2] & in[1] & in[0]; // 4-input AND operation
    out_or  = in[3] | in[2] | in[1] | in[0]; // 4-input OR operation
    out_xor = in[3] ^ in[2] ^ in[1] ^ in[0]; // 4-input XOR operation
end

endmodule
[DONE]