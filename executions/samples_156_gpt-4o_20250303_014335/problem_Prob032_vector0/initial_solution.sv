module TopModule (
    input  wire [2:0] vec,  // 3-bit unsigned input vector
    output wire [2:0] outv, // 3-bit unsigned output vector
    output wire       o2,   // Output connected to vec[2]
    output wire       o1,   // Output connected to vec[1]
    output wire       o0    // Output connected to vec[0]
);

    // Direct assignment of input vector to output vector
    assign outv = vec;

    // Individual bit assignments
    assign o2 = vec[2];
    assign o1 = vec[1];
    assign o0 = vec[0];

endmodule