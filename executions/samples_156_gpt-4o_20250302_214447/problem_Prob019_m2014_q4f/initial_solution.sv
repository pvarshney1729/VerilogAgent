```verilog
module TopModule (
    input  wire in1,  // Input signal 1
    input  wire in2,  // Input signal 2
    output wire out   // Output signal
);

    // Combinational logic: out = in1 AND NOT in2
    assign out = in1 & ~in2;

endmodule
```