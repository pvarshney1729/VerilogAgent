module TopModule (
    input logic [2:0] in,
    output logic [1:0] out
);

    always @(*) begin
        out = 2'b00; // Initialize output
        // Count the number of '1's in the input
        out[0] = in[0] ^ in[1] ^ in[2]; // LSB: parity bit for odd count
        out[1] = (in[0] & in[1]) | (in[1] & in[2]) | (in[0] & in[2]); // MSB: count of pairs
    end

endmodule