```verilog
module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);
    // Combinational logic for 2-input NOR gate
    assign out = ~(in1 | in2);
endmodule
```