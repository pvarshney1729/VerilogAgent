module TopModule (
    input  logic [3:0] x,
    output logic f
);
    assign f = (x[3] & ~x[2] & ~x[1] & x[0]) |  // minterm 2
                (x[3] & x[2] & ~x[1] & ~x[0]) | // minterm 8
                (x[3] & x[2] & x[1]) |          // minterm 10
                (x[3] & ~x[2] & x[1] & x[0]) |  // minterm 3
                (~x[3] & x[2] & x[1] & ~x[0]) | // minterm 6
                (x[3] & ~x[2] & x[1] & ~x[0]);  // minterm 9
endmodule