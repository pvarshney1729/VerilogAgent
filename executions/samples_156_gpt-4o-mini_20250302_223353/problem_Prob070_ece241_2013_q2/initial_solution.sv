module TopModule (
    input logic [3:0] data_in,
    output logic out_sop,
    output logic out_pos
);

    // Minimum sum-of-products (SOP) form logic
    assign out_sop = (data_in == 4'b0010) || (data_in == 4'b0111) || (data_in == 4'b1111);

    // Minimum product-of-sums (POS) form logic
    assign out_pos = !( (data_in == 4'b0000) || (data_in == 4'b0001) || 
                        (data_in == 4'b0100) || (data_in == 4'b0101) || 
                        (data_in == 4'b0110) || (data_in == 4'b1001) || 
                        (data_in == 4'b1010) || (data_in == 4'b1101) || 
                        (data_in == 4'b1110) );

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly