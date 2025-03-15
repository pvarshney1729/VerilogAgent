module TopModule(
    input logic [7:0] in,     // 8-bit input vector
    output logic parity       // Output parity bit
);

    always @(*) begin
        // Compute the even parity bit as the XOR of all input bits
        parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
    end

endmodule