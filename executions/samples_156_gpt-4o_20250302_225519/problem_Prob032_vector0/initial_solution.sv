module TopModule (
    input wire [2:0] vec,    // 3-bit input vector, vec[2] is MSB, vec[0] is LSB
    output wire [2:0] outv,  // 3-bit output vector, outv[2] is MSB, outv[0] is LSB
    output wire o2,          // 1-bit output, connected to vec[2]
    output wire o1,          // 1-bit output, connected to vec[1]
    output wire o0           // 1-bit output, connected to vec[0]
);

    // Direct assignment of the input vector to the output vector.
    assign outv = vec;

    // Assign the most significant bit of vec to o2.
    assign o2 = vec[2];

    // Assign the middle bit of vec to o1.
    assign o1 = vec[1];

    // Assign the least significant bit of vec to o0.
    assign o0 = vec[0];

endmodule