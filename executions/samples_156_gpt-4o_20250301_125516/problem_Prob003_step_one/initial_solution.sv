```verilog
module TopModule(
    output logic one // Output is explicitly declared as logic for clarity
);
    // Continuous assignment to drive the output high
    assign one = 1'b1;
endmodule
```