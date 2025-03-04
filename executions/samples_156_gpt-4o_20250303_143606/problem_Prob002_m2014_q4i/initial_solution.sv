```verilog
module TopModule (
    output logic out
);
    // The output is always driven to 0.
    assign out = 1'b0;
endmodule
```