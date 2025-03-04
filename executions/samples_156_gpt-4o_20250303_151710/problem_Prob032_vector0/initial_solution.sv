module TopModule(
    input [2:0] vec,
    output [2:0] outv,
    output o0,
    output o1,
    output o2
);

    // Directly map the input vector to the output vector
    assign outv = vec;

    // Split the input vector into individual outputs
    assign o0 = vec[0];
    assign o1 = vec[1];
    assign o2 = vec[2];

endmodule