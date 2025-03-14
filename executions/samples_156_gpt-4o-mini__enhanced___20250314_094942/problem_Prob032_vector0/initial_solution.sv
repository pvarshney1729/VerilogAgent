module TopModule (
    input logic [2:0] vec,   // 3-bit input vector
    output logic [2:0] outv, // 3-bit output, same as input vec
    output logic o0,         // 1-bit output, corresponds to vec[0]
    output logic o1,         // 1-bit output, corresponds to vec[1]
    output logic o2          // 1-bit output, corresponds to vec[2]
);

assign outv = vec; // Directly assign vec to outv
assign o0 = vec[0]; // Assign least significant bit to o0
assign o1 = vec[1]; // Assign middle bit to o1
assign o2 = vec[2]; // Assign most significant bit to o2

endmodule