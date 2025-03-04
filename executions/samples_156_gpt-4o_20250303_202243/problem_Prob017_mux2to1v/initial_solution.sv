```verilog
module TopModule (
    input  wire [99:0] a,    // 100-bit input vector 'a'
    input  wire [99:0] b,    // 100-bit input vector 'b'
    input  wire        sel,  // 1-bit selection signal
    output wire [99:0] out   // 100-bit output vector
);

    // Combinational 2-to-1 multiplexer logic
    assign out = sel ? b : a;

endmodule
```