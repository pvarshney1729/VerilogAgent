```verilog
module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);
    // Implement the AND gate with a NOT on in2
    assign out = in1 & ~in2;

endmodule
```