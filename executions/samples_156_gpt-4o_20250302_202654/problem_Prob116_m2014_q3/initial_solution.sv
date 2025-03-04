module TopModule (
    input logic [3:0] x,  // 4-bit input vector: x[3] is MSB, x[0] is LSB
    output logic f        // 1-bit output
);

    assign f = (x[3] & ~x[2] & ~x[1] & x[0]) |  // Covers 10 row, 11 column
               (x[3] & ~x[2] & x[1] & x[0]) |   // Covers 10 row, 10 column
               (x[3] & x[2] & ~x[1]) |          // Covers 11 row, 00 and 01 columns
               (~x[3] & x[2] & x[1] & ~x[0]) |  // Covers 01 row, 11 column
               (~x[3] & x[2] & ~x[1] & x[0]);   // Covers 00 row, 01 column

endmodule