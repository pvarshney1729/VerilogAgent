```verilog
module TopModule (
    input logic a,
    input logic b,
    output logic out
);
    always @(*) begin
        out = ~(a ^ b); // XNOR operation
    end
endmodule
```