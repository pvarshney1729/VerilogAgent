module TopModule (
    input logic [3:0] in_vector,
    output logic out_sop,
    output logic out_pos
);

    // Sum-of-Products (SOP) form for out_sop
    assign out_sop = (~in_vector[3] & ~in_vector[2] & in_vector[1] & ~in_vector[0]) | // 2
                     ( in_vector[3] & ~in_vector[2] & ~in_vector[1] & in_vector[0]) | // 7
                     ( in_vector[3] &  in_vector[2] &  in_vector[1] & in_vector[0]);  // 15

    // Product-of-Sums (POS) form for out_pos
    assign out_pos = ( in_vector[3] |  in_vector[2] | ~in_vector[1] |  in_vector[0]) & // 0, 1, 4, 5, 6, 9, 10, 13, 14
                     ( in_vector[3] | ~in_vector[2] |  in_vector[1] |  in_vector[0]) & // 0, 1, 4, 5, 6, 9, 10, 13, 14
                     (~in_vector[3] |  in_vector[2] |  in_vector[1] |  in_vector[0]);  // 0, 1, 4, 5, 6, 9, 10, 13, 14

endmodule