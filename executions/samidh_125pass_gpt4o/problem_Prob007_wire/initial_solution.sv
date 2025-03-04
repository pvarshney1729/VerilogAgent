```verilog
module TopModule (
    input logic in,    // 1-bit input
    output logic out   // 1-bit output
);
    // Combinational assignment; out mirrors in
    assign out = in;
endmodule
```