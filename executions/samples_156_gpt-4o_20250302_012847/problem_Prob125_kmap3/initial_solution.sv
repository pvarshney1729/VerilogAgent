```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (~c & b) | (c & ~b & a) | (c & d);
    end

endmodule
```