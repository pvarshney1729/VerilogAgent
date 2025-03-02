```verilog
module TopModule (
    input logic [254:0] in,
    output logic [7:0] out
);

    always @(*) begin
        out = 0;
        for (int i = 0; i < 255; i++) begin
            out = out + in[i];
        end
    end

endmodule
```