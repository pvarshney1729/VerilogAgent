[BEGIN]
```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    output logic w,
    output logic x,
    output logic y,
    output logic z
);
    // Combinational logic using always block
    always @(*) begin
        w = a;
        x = b;
        y = b;
        z = c;
    end
endmodule
```
[DONE]