```verilog
module TopModule (
    input wire a,
    input wire b,
    output wire q
);
    assign q = a & b; // Combinational logic implementing AND gate
endmodule
```