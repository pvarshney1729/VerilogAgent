```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic sel,
    output logic out
);

    // Implement a 2-to-1 multiplexer
    assign out = (sel == 1'b0) ? a : b;

endmodule
```