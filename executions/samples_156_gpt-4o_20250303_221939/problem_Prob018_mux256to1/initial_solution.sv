```verilog
module TopModule(
    input logic [255:0] in,
    input logic [7:0] sel,
    output logic out
);

    always_comb begin
        out = in[sel];
    end

endmodule
```