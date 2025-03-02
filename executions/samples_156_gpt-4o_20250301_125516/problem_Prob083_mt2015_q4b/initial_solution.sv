```verilog
module TopModule (
    input logic x,
    input logic y,
    output logic z
);

assign z = (x == 0 && y == 0) || (x == 1 && y == 1);

endmodule
```