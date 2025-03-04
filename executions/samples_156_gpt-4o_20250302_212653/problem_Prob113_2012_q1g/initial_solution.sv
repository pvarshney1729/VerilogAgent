module TopModule (
    input logic [3:0] x,
    output logic f
);

    // Combinational logic to determine the output f based on input x
    assign f = (~x[3] & ~x[2] & ~x[1] & ~x[0]) |
               (~x[3] & x[2] & x[1] & x[0]) |
               (x[3] & ~x[2] & ~x[1]) |
               (x[3] & x[2] & ~x[0]);

endmodule