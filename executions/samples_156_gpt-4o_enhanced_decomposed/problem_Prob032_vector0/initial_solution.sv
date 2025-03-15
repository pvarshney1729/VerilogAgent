module TopModule(
    input logic [2:0] vec,  // 3-bit input vector
    output logic [2:0] outv, // 3-bit output vector
    output logic o2,         // 1-bit output for MSB
    output logic o1,         // 1-bit output for middle bit
    output logic o0          // 1-bit output for LSB
);

    // Assign the input vector directly to the output vector
    assign outv = vec;

    // Split the input vector into individual bits for separate outputs
    assign o2 = vec[2];
    assign o1 = vec[1];
    assign o0 = vec[0];

endmodule