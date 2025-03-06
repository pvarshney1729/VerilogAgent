```verilog
module TopModule (
    input logic a,
    input logic b,
    output logic out
);

    // Combinational logic for XNOR operation
    assign out = ~(a ^ b);

endmodule
```