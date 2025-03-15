module TopModule (
    input logic [2:0] in,
    output logic [1:0] out
);

    always @(*) begin
        out = 2'b00; // Initialize output
        out[0] = in[0] ^ in[1] ^ in[2]; // Count of '1's in the least significant bit
        out[1] = (in[0] & in[1]) | (in[1] & in[2]) | (in[0] & in[2]); // Count of '1's in the most significant bit
    end

endmodule