```verilog
module TopModule (
    input  [3:0] x,  // 4-bit input vector with x[3] as MSB and x[0] as LSB
    output       f   // Single bit output
);

    assign f = (~x[3] & ~x[2] & ~x[1] & ~x[0]) | 
               (~x[3] & ~x[2] &  x[1] &  x[0]) | 
               ( x[3] &  x[2] & ~x[1]) | 
               ( x[3] & ~x[2] &  x[1]);

endmodule
```