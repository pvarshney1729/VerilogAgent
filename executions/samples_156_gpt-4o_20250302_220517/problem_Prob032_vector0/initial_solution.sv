module TopModule (
    input [2:0] vec,
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);
    assign outv = vec;  // Direct mapping of input to output
    assign o0 = vec[0]; // Individual bit outputs
    assign o1 = vec[1];
    assign o2 = vec[2];
endmodule