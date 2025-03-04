```verilog
module TopModule(
    output logic zero
);
    // Constantly drive the output to LOW
    assign zero = 1'b0;
endmodule
```