```verilog
module TopModule (
    input  logic in,
    output logic out
);
    assign out = ~in; // Combinational NOT operation
endmodule
```