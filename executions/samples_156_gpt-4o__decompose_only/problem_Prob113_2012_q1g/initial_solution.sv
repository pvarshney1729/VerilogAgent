module TopModule(
    input [3:0] x,
    output logic f
);

    // Implement the logic for f based on the Karnaugh map
    always @(*) begin
        f = (~x[3] & ~x[2] & ~x[1] & ~x[0]) |  // 00 00
            (~x[3] & ~x[2] &  x[1] &  x[0]) |  // 00 10
            ( x[3] &  x[2] & ~x[1] & ~x[0]) |  // 11 00
            ( x[3] &  x[2] & ~x[1] &  x[0]) |  // 11 10
            ( x[3] &  x[2] &  x[1] & ~x[0]) |  // 11 01
            (~x[3] &  x[2] & ~x[1] & ~x[0]) |  // 10 00
            (~x[3] &  x[2] & ~x[1] &  x[0]);   // 10 10
    end

endmodule