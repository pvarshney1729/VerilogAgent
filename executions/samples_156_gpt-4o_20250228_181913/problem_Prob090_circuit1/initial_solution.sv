```verilog
module TopModule(
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    output logic q  // 1-bit output
);
    assign q = a & b;  // Output q is the AND of inputs a and b
endmodule
```