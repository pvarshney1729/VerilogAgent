```verilog
module TopModule (
    output logic zero
);
    assign zero = 1'b0; // Constant assignment to ensure zero is always LOW
endmodule
```