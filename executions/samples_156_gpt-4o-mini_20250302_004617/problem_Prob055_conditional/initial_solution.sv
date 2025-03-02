module TopModule (
    input  logic [7:0] a,  // Input A, 8 bits, unsigned
    input  logic [7:0] b,  // Input B, 8 bits, unsigned
    input  logic [7:0] c,  // Input C, 8 bits, unsigned
    input  logic [7:0] d,  // Input D, 8 bits, unsigned
    output logic [7:0] min // Output minimum value, 8 bits, unsigned
);

    assign min = (a <= b) ? (a <= c ? (a <= d ? a : d) : (c <= d ? c : d)) :
                            (b <= c ? (b <= d ? b : d) : (c <= d ? c : d));

endmodule