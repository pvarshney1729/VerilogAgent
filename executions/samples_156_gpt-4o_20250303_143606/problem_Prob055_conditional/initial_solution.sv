```verilog
module TopModule (
    input  [7:0] a, // 8-bit unsigned input
    input  [7:0] b, // 8-bit unsigned input
    input  [7:0] c, // 8-bit unsigned input
    input  [7:0] d, // 8-bit unsigned input
    output [7:0] min // 8-bit unsigned output representing the minimum value
);

    assign min = (a < b) ? ((a < c) ? ((a < d) ? a : d) : ((c < d) ? c : d)) :
                 ((b < c) ? ((b < d) ? b : d) : ((c < d) ? c : d));

endmodule
```