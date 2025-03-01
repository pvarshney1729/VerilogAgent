```verilog
module TopModule(
    output logic zero  // 1-bit output
);
    // Continuous assignment to ensure zero is always LOW
    assign zero = 1'b0;
endmodule
```