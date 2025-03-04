```verilog
module TopModule (
    output logic out
);
    // Drive output low (0) continuously
    assign out = 1'b0;
endmodule
```