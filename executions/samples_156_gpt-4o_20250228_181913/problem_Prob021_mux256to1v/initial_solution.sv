```verilog
module TopModule (
    input [1023:0] data_in,
    input [7:0] select,
    output [3:0] data_out
);
    assign data_out = data_in[select*4 +: 4];
endmodule
```