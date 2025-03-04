```verilog
module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    assign out = (~c & ~d) | (~c & ~a & b) | (~c & ~b) | (a & ~b & c);

endmodule
```