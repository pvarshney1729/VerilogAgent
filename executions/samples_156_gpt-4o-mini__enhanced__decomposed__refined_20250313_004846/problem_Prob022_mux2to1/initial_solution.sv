```verilog
[BEGIN]
module TopModule(
    input logic a,
    input logic b,
    input logic sel,
    output logic out
);
    // Combinational logic for 2-to-1 multiplexer
    always @(*) begin
        out = sel ? b : a;
    end
endmodule
[DONE]
```