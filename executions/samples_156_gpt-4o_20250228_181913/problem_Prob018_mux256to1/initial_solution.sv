```verilog
module TopModule (
    input  wire [255:0] in,  // 256-bit wide input vector, 0 to 255 index with in[0] as LSB
    input  wire [7:0]  sel,  // 8-bit selector, unsigned
    output wire        out   // 1-bit output
);

    // Assign the selected bit from the input vector to the output
    assign out = in[sel];

endmodule
```