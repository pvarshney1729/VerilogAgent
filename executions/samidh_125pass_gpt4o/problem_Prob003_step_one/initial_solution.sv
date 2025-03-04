```verilog
module TopModule (
    output logic out_high
);

    // The output is always driven high
    assign out_high = 1'b1;

endmodule
```