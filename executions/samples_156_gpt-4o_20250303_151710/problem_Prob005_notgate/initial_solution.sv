```verilog
module TopModule (
    input logic in,  // 1-bit input
    output logic out // 1-bit output
);

    // Implement NOT gate logic
    assign out = ~in;

endmodule
```