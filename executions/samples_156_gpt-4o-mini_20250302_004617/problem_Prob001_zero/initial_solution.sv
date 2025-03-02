```verilog
module TopModule(
    output logic zero // Constant LOW output
);
    assign zero = 1'b0; // Assign LOW to the output
endmodule
```