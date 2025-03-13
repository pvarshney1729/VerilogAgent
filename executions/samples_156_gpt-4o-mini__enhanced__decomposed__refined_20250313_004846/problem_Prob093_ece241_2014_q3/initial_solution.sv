[BEGIN]
```verilog
module TopModule(
    input logic c,              // 1-bit input, unsigned
    input logic d,              // 1-bit input, unsigned
    input logic a,              // 1-bit selector input for the 4-to-1 mux
    input logic b,              // 1-bit selector input for the 4-to-1 mux
    output logic [3:0] mux_in   // 4-bit output, unsigned, LSB = mux_in[0]
);

always @(*) begin
    mux_in[0] = (~c & d) | (c & ~d); // from K-map row 00 and 01
    mux_in[1] = 1'b0;                // from K-map row 01
    mux_in[2] = c & d;               // from K-map row 11
    mux_in[3] = c;                   // from K-map row 10
end

endmodule
```
[DONE]