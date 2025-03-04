```verilog
module TopModule (
    logic a,  // 1-bit input
    logic b,  // 1-bit input
    logic out // 1-bit output
);
    assign out = a & b; // Combinational logic for AND gate
endmodule
```