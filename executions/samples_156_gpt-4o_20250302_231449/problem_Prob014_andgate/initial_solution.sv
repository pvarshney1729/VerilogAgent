```verilog
module TopModule (
    input logic a,  // Input a
    input logic b,  // Input b
    output logic out // Output of AND gate
);
    assign out = a & b; // Logical AND operation
endmodule
```