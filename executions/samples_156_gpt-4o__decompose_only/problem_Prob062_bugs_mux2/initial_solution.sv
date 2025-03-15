module TopModule (
    input        sel,
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out
);

    // Use the select signal to choose between inputs a and b
    assign out = sel ? b : a;

endmodule