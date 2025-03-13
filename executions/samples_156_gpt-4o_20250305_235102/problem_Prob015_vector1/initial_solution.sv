[BEGIN]
```verilog
module TopModule (
    input  logic [15:0] in,    // 16-bit input vector
    output logic [7:0] out_hi, // Upper byte output
    output logic [7:0] out_lo   // Lower byte output
);

always @(*) begin
    out_hi = in[15:8]; // Assign the upper 8 bits to out_hi
    out_lo = in[7:0];  // Assign the lower 8 bits to out_lo
end

endmodule
```
[DONE]