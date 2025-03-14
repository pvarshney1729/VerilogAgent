```verilog
module TopModule(
    input logic a,
    input logic b,
    input logic sel,
    output logic out
);
    assign out = (sel == 1'b1) ? b : a; // Multiplexer logic using conditional operator
endmodule
```