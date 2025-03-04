module TopModule(
    input  logic [3:0] in,
    output logic out_sop,
    output logic out_pos
);

    // Minimum Sum-of-Products (SOP) form
    assign out_sop = (in == 4'd2) | (in == 4'd7) | (in == 4'd15);

    // Minimum Product-of-Sums (POS) form
    assign out_pos = (in[3] | in[2] | ~in[1] | in[0]) & 
                     (in[3] | ~in[2] | in[1] | ~in[0]) & 
                     (~in[3] | in[2] | in[1] | in[0]);

endmodule