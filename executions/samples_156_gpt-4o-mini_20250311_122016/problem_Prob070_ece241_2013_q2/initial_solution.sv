```verilog
[BEGIN]
module TopModule (
    input logic [3:0] in,       // 4-bit input vector representing a, b, c, d
    output logic out_sop,       // Output for minimum sum-of-products form
    output logic out_pos        // Output for minimum product-of-sums form
);

always @(*) begin
    out_sop = (~in[3] & ~in[2] & in[1] & ~in[0]) ||  // 2 (0010)
               (~in[3] & in[2] & in[1] & in[0])  ||  // 7 (0111)
               (in[3] & in[2] & in[1] & in[0]);     // 15 (1111)

    out_pos = (~in[3] | ~in[2] | ~in[1]) &&  // 0, 1
               (~in[3] | ~in[2] | in[0]) &&  // 4, 5
               (~in[3] | in[2] | ~in[1]) &&  // 6
               (in[3] | ~in[2] | ~in[0]) &&  // 9
               (in[3] | ~in[2] | in[1]) &&   // 10
               (in[3] | in[2] | ~in[1]) &&   // 13
               (in[3] | in[2] | in[0]);       // 14
end

endmodule
[DONE]
```