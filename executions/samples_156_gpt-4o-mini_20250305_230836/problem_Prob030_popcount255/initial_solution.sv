```verilog
[BEGIN]
module TopModule (
    input logic [254:0] in,
    output logic [7:0] out
);

    always @(*) begin
        out = 8'b0; // Explicit size for the constant
        for (int i = 0; i < 255; i++) begin
            out = out + in[i]; // in[i] is already logic type
        end
    end

endmodule
[DONE]
```