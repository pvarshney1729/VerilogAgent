```verilog
module TopModule (
    input logic in1,  // 1-bit input signal
    input logic in2,  // 1-bit input signal
    output logic out  // 1-bit output signal
);

    // Combinational logic for AND gate with inverted in2
    assign out = in1 & ~in2;

endmodule
```