```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic sel,
    output logic out
);
    assign out = (sel == 1'b0) ? a : b;
endmodule
```