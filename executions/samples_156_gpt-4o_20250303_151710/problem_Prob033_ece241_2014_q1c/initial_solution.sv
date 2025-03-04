```verilog
module TopModule(
    input  wire signed [7:0] a,
    input  wire signed [7:0] b,
    output wire signed [7:0] s,
    output wire overflow
);

    assign s = a + b;
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
```