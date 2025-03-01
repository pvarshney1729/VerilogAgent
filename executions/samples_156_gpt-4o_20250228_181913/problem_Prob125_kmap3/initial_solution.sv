```verilog
module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (!c && !d && b) || (c && (a || b));
    end

endmodule
```