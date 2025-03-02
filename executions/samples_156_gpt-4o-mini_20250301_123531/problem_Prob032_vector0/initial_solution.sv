module TopModule (
    input  logic [2:0] vec,    // 3-bit input vector, bit[2] is MSB
    output logic [2:0] outv,   // 3-bit output vector, aligned with input vec
    output logic       o2,      // 1-bit output, connected to vec[2]
    output logic       o1,      // 1-bit output, connected to vec[1]
    output logic       o0       // 1-bit output, connected to vec[0]
);

assign outv = vec;  // Directly pass input to output
assign o2 = vec[2]; // Connect to MSB
assign o1 = vec[1]; // Connect to middle bit
assign o0 = vec[0]; // Connect to LSB

endmodule