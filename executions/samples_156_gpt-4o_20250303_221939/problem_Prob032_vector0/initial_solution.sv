module TopModule(
    input  logic [2:0] vec,
    output logic [2:0] outv,
    output logic o2,
    output logic o1,
    output logic o0
);

    // Direct connection of input vector to output vector
    assign outv = vec;

    // Splitting the vector into individual bits
    assign o2 = vec[2];
    assign o1 = vec[1];
    assign o0 = vec[0];

endmodule