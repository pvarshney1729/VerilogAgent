```verilog
module TopModule (
    input logic x,  // 1-bit input
    input logic y,  // 1-bit input
    output logic z  // 1-bit output
);
    // Combinational logic
    assign z = (x ^ y) & x;
endmodule
```