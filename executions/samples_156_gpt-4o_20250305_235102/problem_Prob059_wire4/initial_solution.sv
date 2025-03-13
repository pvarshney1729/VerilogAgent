```verilog
[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    output logic w,
    output logic x,
    output logic y,
    output logic z
);
    always @(*) begin
        w = a; 
        x = b; 
        y = b; 
        z = c; 
    end
endmodule
[DONE]
```