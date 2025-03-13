```verilog
module TopModule (
    output logic one
);
    // Drive the output constantly to logic high
    assign one = 1'b1;
endmodule
```