```verilog
module TopModule(
    output logic out
);
    // Continuously drive the output to logic low
    assign out = 1'b0;
endmodule
```