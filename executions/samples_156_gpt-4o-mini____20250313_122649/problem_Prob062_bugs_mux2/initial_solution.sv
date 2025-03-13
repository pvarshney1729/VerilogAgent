module TopModule (
    input        sel,
    input  [7:0] a,
    input  [7:0] b,
    output logic [7:0] out
);

    assign out = (sel) ? b : a;

endmodule