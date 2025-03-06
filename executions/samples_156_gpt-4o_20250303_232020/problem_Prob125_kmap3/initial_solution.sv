module TopModule (
    input  wire a,  // Input bit a
    input  wire b,  // Input bit b
    input  wire c,  // Input bit c
    input  wire d,  // Input bit d (don't-care in some cases)
    output wire out // Output bit out
);

    assign out = (c & b) | (~a & b);

endmodule