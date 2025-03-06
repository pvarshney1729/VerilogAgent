```verilog
[BEGIN]
module TopModule(
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    always @(*) begin
        out_and = &in; // AND reduction operator
        out_or = |in;  // OR reduction operator
        out_xor = ^in; // XOR reduction operator
    end

endmodule
[DONE]
```