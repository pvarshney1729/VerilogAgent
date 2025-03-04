```verilog
module TopModule (
    input  logic a,   // Input port 'a', 1-bit wide, unsigned
    input  logic b,   // Input port 'b', 1-bit wide, unsigned
    output logic out  // Output port 'out', 1-bit wide, unsigned
);

assign out = a & b; // Combinational AND operation

endmodule
```