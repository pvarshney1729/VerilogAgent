```verilog
module TopModule (
    output logic high_output
);
    // Continuous assignment of a constant logic high to the output
    assign high_output = 1'b1;

endmodule
```