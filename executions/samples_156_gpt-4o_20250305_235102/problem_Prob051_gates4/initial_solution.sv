```verilog
[BEGIN]
module TopModule (
    input  logic [3:0] in,        // 4-bit input vector, in[3] is MSB and in[0] is LSB.
    output logic       out_and,   // Output for 4-input AND operation.
    output logic       out_or,    // Output for 4-input OR operation.
    output logic       out_xor    // Output for 4-input XOR operation.
);

    always @(*) begin
        out_and = in[3] & in[2] & in[1] & in[0]; // 4-input AND operation
        out_or  = in[3] | in[2] | in[1] | in[0]; // 4-input OR operation
        out_xor = in[3] ^ in[2] ^ in[1] ^ in[0]; // 4-input XOR operation
    end

endmodule
[DONE]
```