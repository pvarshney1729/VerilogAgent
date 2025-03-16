```verilog
module TopModule (
    output logic zero  // Single-bit output port, named 'zero'.
);

    assign zero = 1'b0;  // Constantly assign logic LOW to the output.

endmodule
```