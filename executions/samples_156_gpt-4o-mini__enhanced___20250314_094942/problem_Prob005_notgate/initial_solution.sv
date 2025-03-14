```verilog
module TopModule (
    input logic in,    // 1-bit input signal
    output logic out   // 1-bit output signal
);

    assign out = ~in;  // Implementing the NOT gate

endmodule
```