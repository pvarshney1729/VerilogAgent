```verilog
module TopModule(
    output logic zero // Output port declaration
);

// Drive the output to a constant LOW
assign zero = 1'b0;

endmodule
```