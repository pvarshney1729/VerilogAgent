module TopModule (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] min
);

    logic [7:0] min_ab;
    logic [7:0] min_cd;

    // Compare a and b
    assign min_ab = (a < b) ? a : b;

    // Compare c and d
    assign min_cd = (c < d) ? c : d;

    // Compare the results to find the overall minimum
    assign min = (min_ab < min_cd) ? min_ab : min_cd;

endmodule