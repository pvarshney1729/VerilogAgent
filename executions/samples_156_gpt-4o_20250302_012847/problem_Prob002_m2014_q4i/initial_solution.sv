```verilog
module TopModule(
    output logic out
);

    // Continuous assignment to drive 'out' to logic low (0)
    assign out = 1'b0;

endmodule
```