[BEGIN]
```verilog
module TopModule (
    input logic [31:0] in,
    output logic [31:0] out
);

    always @(*) begin
        out[31:24] = in[23:16]; // 8'b00000000
        out[23:16] = in[31:24]; // 8'b00000000
        out[15:8]  = in[7:0];   // 8'b00000000
        out[7:0]   = in[15:8];  // 8'b00000000
    end

endmodule
```
[DONE]