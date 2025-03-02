```verilog
module TopModule (
    output logic out_signal
);
    // Continuous assignment to drive the output to 0
    assign out_signal = 1'b0;
endmodule
```