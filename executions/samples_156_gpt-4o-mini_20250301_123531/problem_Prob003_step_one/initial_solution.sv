```verilog
module TopModule(
    logic one      // Output port, named 'one', continuously driven high
);

    // Assign the constant value '1' to the output port.
    assign one = 1'b1;  // Use Verilog's binary notation for clarity.

endmodule
```