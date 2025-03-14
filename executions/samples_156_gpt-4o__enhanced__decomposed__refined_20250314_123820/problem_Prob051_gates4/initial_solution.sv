[BEGIN]
module TopModule(
    input logic [3:0] i_in,
    output logic o_out_and,
    output logic o_out_or,
    output logic o_out_xor
);

    always @(*) begin
        o_out_and = &i_in;   // AND all bits of i_in
        o_out_or  = |i_in;   // OR all bits of i_in
        o_out_xor = ^i_in;   // XOR all bits of i_in
    end

endmodule
[DONE]