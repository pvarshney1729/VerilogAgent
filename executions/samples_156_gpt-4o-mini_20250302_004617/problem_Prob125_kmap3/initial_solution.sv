```verilog
module TopModule(
    logic a,
    logic b,
    logic c,
    logic d,
    logic out
);

assign out = (~c & b & ~a) | (c & a) | (c & ~a & b);

endmodule
```