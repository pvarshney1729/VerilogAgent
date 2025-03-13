```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);
    assign out = (c & ~b) | (c & a) | (b & a) | (c & ~a);
endmodule
```