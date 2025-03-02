```verilog
module TopModule (
    input logic in,   // 1-bit input
    output logic out  // 1-bit output
);

assign out = in; // Combinational pass-through

endmodule
```