```verilog
module TopModule (
    input  [255:0] in,
    input  [7:0]   sel,
    output logic    out
);

    always @(*) begin
        out = in[sel[7:0]];
    end

endmodule
```