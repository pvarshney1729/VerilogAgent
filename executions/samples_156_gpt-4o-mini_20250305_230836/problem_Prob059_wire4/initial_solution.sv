[BEGIN]
```verilog
module TopModule (
    input logic a, // 1-bit input, unsigned
    input logic b, // 1-bit input, unsigned
    input logic c, // 1-bit input, unsigned
    output logic w, // 1-bit output, directly connected from input `a`
    output logic x, // 1-bit output, directly connected from input `b`
    output logic y, // 1-bit output, directly connected from input `b`
    output logic z  // 1-bit output, directly connected from input `c`
);

    always @(*) begin
        w = a; // 1-bit assignment
        x = b; // 1-bit assignment
        y = b; // 1-bit assignment
        z = c; // 1-bit assignment
    end

endmodule
```
[DONE]