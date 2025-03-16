```verilog
module TopModule(
    input  wire [255:0] in,   // 256-bit wide input vector
    input  wire [7:0]   sel,  // 8-bit wide selection input
    output wire         out   // 1-bit wide output
);

    // Assign the selected bit from 'in' to 'out' based on 'sel'
    assign out = in[sel];

endmodule
```