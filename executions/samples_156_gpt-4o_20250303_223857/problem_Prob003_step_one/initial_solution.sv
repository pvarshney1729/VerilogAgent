```verilog
module TopModule (
    output logic constant_one
);

    // Continuous assignment for constant high
    assign constant_one = 1'b1;

endmodule
```