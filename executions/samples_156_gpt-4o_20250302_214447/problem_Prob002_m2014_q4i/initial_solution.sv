```verilog
module TopModule (
    output logic out // Output is explicitly defined as logic
);

    // Drive the output to logic 0
    assign out = 1'b0; // Explicitly specify the binary value

endmodule
```