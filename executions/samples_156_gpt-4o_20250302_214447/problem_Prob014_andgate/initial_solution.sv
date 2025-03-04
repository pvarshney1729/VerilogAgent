```verilog
module TopModule (
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    output logic out // 1-bit output
);

    // Combinational logic for 2-input AND gate
    assign out = a & b;

endmodule
```