module TopModule (
    input logic [7:0] in,    // 8-bit input data (in[0] = LSB, in[7] = MSB)
    output logic parity       // 1-bit output for even parity
);

always @(*) begin
    // Calculate even parity
    parity = ^in; // XOR reduction for even parity
end

endmodule