```verilog
module TopModule (
    input  [7:0] in,   // 8-bit input vector
    output [7:0] out   // 8-bit output vector
);

    // Continuous assignment for combinational logic
    assign out = {in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]};

endmodule
```