module TopModule (
    input logic [3:0] x,
    output logic f
);

    // Combinational logic derived from the Karnaugh map
    assign f = (~x[3] & ~x[2] & ~x[1] & ~x[0]) |
               (~x[3] & ~x[2] & x[1] & x[0]) |
               (x[3] & x[2] & ~x[1]) |
               (x[3] & ~x[2] & x[1]);

endmodule