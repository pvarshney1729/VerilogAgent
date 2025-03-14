```
[BEGIN]
module TopModule (
    input logic [15:0] in,        // 16-bit input, in[15] is MSB and in[0] is LSB
    output logic [7:0] out_hi,    // 8-bit output for the higher byte
    output logic [7:0] out_lo     // 8-bit output for the lower byte
);

always @(*) begin
    out_hi = in[15:8]; // Assign the upper byte
    out_lo = in[7:0];  // Assign the lower byte
end

endmodule
[DONE]
```