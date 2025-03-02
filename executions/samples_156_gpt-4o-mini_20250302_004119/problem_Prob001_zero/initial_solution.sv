```verilog
module TopModule (
    output logic zero
);

    // Continuous assignment to drive zero output low
    assign zero = 1'b0;

endmodule
```