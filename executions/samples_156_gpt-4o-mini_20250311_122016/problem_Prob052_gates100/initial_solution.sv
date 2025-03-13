```verilog
module TopModule(
    input [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

always @(*) begin
    out_and = &in; // 1'b1 if all bits are 1
    out_or = |in;  // 1'b1 if at least one bit is 1
    out_xor = ^in; // 1'b1 if an odd number of bits are 1
end

endmodule
```