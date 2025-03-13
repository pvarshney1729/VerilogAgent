```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    assign out = (~a & ~b & ~c) | (~a & ~b & d) | (~a & c & ~d) | (b & c & d) | (b & ~c & ~d) | (a & ~b & ~d);

endmodule
```