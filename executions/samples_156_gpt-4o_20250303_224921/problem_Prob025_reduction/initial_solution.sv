```verilog
module TopModule (
    input  logic [7:0] in,      // 8-bit input data, where in[0] is the least significant bit (LSB)
    output logic       parity   // 1-bit output representing the computed even parity
);

    always @(*) begin
        parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
    end

endmodule
```