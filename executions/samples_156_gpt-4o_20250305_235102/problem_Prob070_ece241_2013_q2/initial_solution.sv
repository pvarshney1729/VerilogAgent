```verilog
[BEGIN]
module TopModule (
    input  logic [3:0] in,      // 4-bit input vector where bit[3] is the MSB and bit[0] is the LSB
    output logic       out_sop, // Output in sum-of-products form
    output logic       out_pos   // Output in product-of-sums form
);

    // Combinational logic for outputs
    always @(*) begin
        out_sop = (in == 4'b0010) | // Decimal 2
                  (in == 4'b0111) | // Decimal 7
                  (in == 4'b1111);   // Decimal 15

        out_pos = ((in[3] | in[2] | ~in[1] | ~in[0]) & // Maxterm for 0
                    (in[3] | ~in[2] | in[1] | in[0]) & // Maxterm for 1
                    (~in[3] | in[2] | in[1] | in[0]) & // Maxterm for 4
                    (~in[3] | in[2] | ~in[1] | in[0]) & // Maxterm for 5
                    (~in[3] | in[2] | ~in[1] | ~in[0]) & // Maxterm for 6
                    (in[3] | ~in[2] | in[1] | ~in[0]) & // Maxterm for 9
                    (in[3] | ~in[2] | ~in[1] | in[0]) & // Maxterm for 10
                    (in[3] | in[2] | ~in[1] | in[0]) & // Maxterm for 13
                    (in[3] | in[2] | in[1] | ~in[0]);  // Maxterm for 14
    end

endmodule
[DONE]
```