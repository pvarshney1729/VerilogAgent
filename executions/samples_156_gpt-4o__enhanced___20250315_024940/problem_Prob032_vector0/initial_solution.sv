module TopModule (
    input logic [2:0] vec,
    output logic [2:0] outv,
    output logic o0,
    output logic o1,
    output logic o2
);

    // Assign the output vector directly to the input vector
    assign outv = vec;

    // Assign the individual bits of the input vector to the respective output signals
    assign o0 = vec[0];
    assign o1 = vec[1];
    assign o2 = vec[2];

endmodule