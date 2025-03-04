```verilog
module TopModule (
    input logic [99:0] a,
    input logic [99:0] b,
    input logic sel,
    output logic [99:0] out
);
    always_comb begin
        out = sel ? b : a;
    end
endmodule
```