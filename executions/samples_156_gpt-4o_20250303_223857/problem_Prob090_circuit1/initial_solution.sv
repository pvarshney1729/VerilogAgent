```verilog
module TopModule (
    input logic a,
    input logic b,
    output logic q
);
    assign q = a & b; // Implementing the logic function q = a AND b
endmodule
```