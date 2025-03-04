```verilog
module TopModule(
    input logic in1,
    input logic in2,
    output logic out
);
    // Implementing the logic: out = in1 AND (NOT in2)
    assign out = in1 & ~in2;
endmodule
```