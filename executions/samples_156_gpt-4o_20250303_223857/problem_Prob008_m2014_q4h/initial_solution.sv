```verilog
module TopModule (
    input logic in,
    output logic out
);
    assign out = in;  // Combinational assignment, no clock dependency.
endmodule
```