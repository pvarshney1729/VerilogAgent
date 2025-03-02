```verilog
module TopModule(
    input  signed [7:0] data_in,
    output signed [31:0] data_out
);
    assign data_out = {{24{data_in[7]}}, data_in};
endmodule
```