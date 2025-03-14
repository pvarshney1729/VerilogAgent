```verilog
module TopModule (
    output logic zero  // 1-bit output that is always LOW
);

    // Assign a constant value to the output
    assign zero = 1'b0;

endmodule
```