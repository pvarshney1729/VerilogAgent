```verilog
module TopModule(
    input logic x,
    input logic y,
    output logic z
);
    // Implement the boolean function
    assign z = (x ^ y) & x;
endmodule
```