```verilog
module TopModule (
    input logic a,   // 1-bit input
    input logic b,   // 1-bit input
    input logic c,   // 1-bit input
    input logic d,   // 1-bit input
    output logic out,   // 1-bit output
    output logic out_n  // 1-bit inverted output
);

assign out = (a & b) | (c & d);
assign out_n = ~out;

endmodule
```