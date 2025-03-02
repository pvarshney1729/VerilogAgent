```verilog
module TopModule (
    input  wire [7:0] a,  // 8-bit unsigned input
    input  wire [7:0] b,  // 8-bit unsigned input
    input  wire [7:0] c,  // 8-bit unsigned input
    input  wire [7:0] d,  // 8-bit unsigned input
    output wire [7:0] min // 8-bit unsigned output
);

    assign min = (a < b && a < c && a < d) ? a :
                 (b < a && b < c && b < d) ? b :
                 (c < a && c < b && c < d) ? c : d;

endmodule
```