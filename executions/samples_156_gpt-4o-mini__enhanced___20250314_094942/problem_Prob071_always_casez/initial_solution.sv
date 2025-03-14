module TopModule (
    input logic [7:0] in,      // 8-bit input vector (unsigned)
    output logic [2:0] pos     // 3-bit output representing the index of the first high bit
);

always @(*) begin
    pos = 3'b000; // Default output for no high bits

    if (in[0]) pos = 3'd0;  // Bit 0 is high
    else if (in[1]) pos = 3'd1; // Bit 1 is high
    else if (in[2]) pos = 3'd2; // Bit 2 is high
    else if (in[3]) pos = 3'd3; // Bit 3 is high
    else if (in[4]) pos = 3'd4; // Bit 4 is high
    else if (in[5]) pos = 3'd5; // Bit 5 is high
    else if (in[6]) pos = 3'd6; // Bit 6 is high
    else if (in[7]) pos = 3'd7; // Bit 7 is high
end

endmodule