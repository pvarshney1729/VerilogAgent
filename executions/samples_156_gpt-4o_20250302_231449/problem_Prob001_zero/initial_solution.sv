```verilog
module TopModule(
    output logic zero
);
    // Constantly assign the output to logic LOW
    assign zero = 1'b0;
endmodule
```