```verilog
module TopModule (
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    input logic c,  // 1-bit input
    input logic d,  // 1-bit input (don't-care in some cases)
    output logic out // 1-bit output
);

    always @(*) begin
        out = (~c & b) | (c & a) | (c & b);
    end

endmodule
```