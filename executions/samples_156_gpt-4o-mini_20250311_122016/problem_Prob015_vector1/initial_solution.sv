[BEGIN]
```verilog
module BitSplitter(
    input  logic [15:0] in,     // 16-bit input half-word
    output logic [7:0]  out_hi, // 8-bit output for upper byte [15:8]
    output logic [7:0]  out_lo   // 8-bit output for lower byte [7:0]
);

    always @(*) begin
        out_hi = in[15:8];  // Assign upper byte
        out_lo = in[7:0];   // Assign lower byte
    end

endmodule
```
[DONE]