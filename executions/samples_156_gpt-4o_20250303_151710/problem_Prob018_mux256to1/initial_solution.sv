```verilog
module TopModule (
    input  wire [255:0] data_in, // 256-bit input vector, indexed from 0 to 255
    input  wire [7:0]   select,  // 8-bit select input, determines which bit to output
    output wire         data_out // 1-bit output, selected from data_in
);

    // Combinational logic for 256-to-1 multiplexer
    assign data_out = data_in[select];

endmodule
```