module TopModule (
    input  logic [2:0] vec,  // 3-bit wide unsigned input vector
    output logic [2:0] outv, // 3-bit wide unsigned output vector
    output logic       o0,    // 1-bit output, connected to vec[0]
    output logic       o1,    // 1-bit output, connected to vec[1]
    output logic       o2     // 1-bit output, connected to vec[2]
);

assign outv = vec;
assign o0 = vec[0];
assign o1 = vec[1];
assign o2 = vec[2];

endmodule