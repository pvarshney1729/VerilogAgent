```verilog
module TopModule(
    output logic one
);
    // Combinational logic that continuously drives 'one' to logic high.
    assign one = 1'b1;
endmodule
```