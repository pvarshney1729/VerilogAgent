module TopModule(
    input logic [31:0] in,
    output logic [31:0] out
);

    // Reverse the byte order of the input
    always @(*) begin
        out[31:24] = in[7:0];   // Least significant byte of 'in' becomes most significant byte of 'out'
        out[23:16] = in[15:8];  // Third most significant byte of 'in' becomes second most significant byte of 'out'
        out[15:8]  = in[23:16]; // Second most significant byte of 'in' becomes third most significant byte of 'out'
        out[7:0]   = in[31:24]; // Most significant byte of 'in' becomes least significant byte of 'out'
    end

endmodule