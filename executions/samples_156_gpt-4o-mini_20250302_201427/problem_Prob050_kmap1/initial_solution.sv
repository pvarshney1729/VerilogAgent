```verilog
module TopModule (
    logic a,
    logic b,
    logic c,
    logic out
);
    assign out = (b & ~a) | (c & ~a) | (b & c);
endmodule
```