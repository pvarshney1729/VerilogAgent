module TopModule (
    input        sel,
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out
);

    // Use a combinational assignment to select between a and b based on sel
    assign out = sel ? b : a;

endmodule