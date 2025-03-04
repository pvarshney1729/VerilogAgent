```verilog
module TopModule(
    input  [3:0] in,
    output [1:0] pos
);

    assign pos = (in[3] == 1'b1) ? 2'd3 :
                 (in[2] == 1'b1) ? 2'd2 :
                 (in[1] == 1'b1) ? 2'd1 :
                 2'd0;

endmodule
```