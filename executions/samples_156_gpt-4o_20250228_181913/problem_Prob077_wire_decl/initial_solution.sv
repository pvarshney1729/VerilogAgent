```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);
    logic wire_ab, wire_cd;

    assign wire_ab = a & b;
    assign wire_cd = c & d;
    assign out = wire_ab | wire_cd;
    assign out_n = ~out;

endmodule
```