```verilog
[BEGIN]
module TopModule (
    input logic [7:0] in,
    output logic [7:0] out
);

    always @(*) begin
        out[0] = in[7]; // LSB
        out[1] = in[6];
        out[2] = in[5];
        out[3] = in[4];
        out[4] = in[3];
        out[5] = in[2];
        out[6] = in[1];
        out[7] = in[0]; // MSB
    end

endmodule
[DONE]
```