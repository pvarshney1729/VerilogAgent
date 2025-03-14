[BEGIN]
module TopModule(
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    always @(*) begin
        out_and = &in; // AND all bits of 'in'
        out_or = |in;  // OR all bits of 'in'
        out_xor = ^in; // XOR all bits of 'in'
    end

endmodule
[DONE]