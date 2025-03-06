[BEGIN]
```verilog
module TopModule(
    input logic [7:0] in,
    output logic [7:0] out
);

    always @(*) begin
        out[7] = in[0]; // 1'b0 is not used here, but the logic is correct
        out[6] = in[1]; // 1'b0 is not used here, but the logic is correct
        out[5] = in[2]; // 1'b0 is not used here, but the logic is correct
        out[4] = in[3]; // 1'b0 is not used here, but the logic is correct
        out[3] = in[4]; // 1'b0 is not used here, but the logic is correct
        out[2] = in[5]; // 1'b0 is not used here, but the logic is correct
        out[1] = in[6]; // 1'b0 is not used here, but the logic is correct
        out[0] = in[7]; // 1'b0 is not used here, but the logic is correct
    end

endmodule
```
[DONE]