```verilog
module TopModule(
    input logic a,       // 1-bit input, active-high
    input logic b,       // 1-bit input, active-high
    output logic q       // 1-bit output, active-high
);

    assign q = a & b;

endmodule
```