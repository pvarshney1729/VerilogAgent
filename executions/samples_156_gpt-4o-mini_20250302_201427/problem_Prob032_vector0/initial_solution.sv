module TopModule (
    input logic [2:0] vec,   // 3-bit input vector, bit[0] is LSB
    output logic [2:0] outv, // 3-bit output vector, directly mirrors 'vec'
    output logic o2,         // 1-bit output, connected to vec[2]
    output logic o1,         // 1-bit output, connected to vec[1]
    output logic o0          // 1-bit output, connected to vec[0]
);

assign outv = vec; // Direct mapping of vec to outv
assign o2 = vec[2]; // Output o2 connected to vec[2]
assign o1 = vec[1]; // Output o1 connected to vec[1]
assign o0 = vec[0]; // Output o0 connected to vec[0]

endmodule