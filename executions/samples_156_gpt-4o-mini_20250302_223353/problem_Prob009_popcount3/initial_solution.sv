module TopModule (
    input  logic [2:0] in,  // 3-bit input vector
    output logic [1:0] out  // 2-bit output vector
);
    // Combinational logic for population count
    assign out = in[0] + in[1] + in[2];
endmodule