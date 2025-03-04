```verilog
module TopModule (
    input logic x,  // 1-bit unsigned input
    input logic y,  // 1-bit unsigned input
    output logic z  // 1-bit unsigned output
);

assign z = (x ^ y) & x;

endmodule
```