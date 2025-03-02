```verilog
module TopModule (
    input logic in_signal,       // Single-bit input
    output logic out_signal      // Single-bit output
);

    // Combinational logic for NOT operation
    assign out_signal = ~in_signal;

endmodule
```