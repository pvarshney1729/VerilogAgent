```verilog
module TopModule(
    input [7:0] in,
    output reg parity
);

    always @(*) begin
        parity = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];
    end

endmodule
```