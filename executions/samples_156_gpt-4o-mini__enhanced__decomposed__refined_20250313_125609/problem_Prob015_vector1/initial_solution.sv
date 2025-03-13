[BEGIN]
module TopModule (
    input logic [15:0] in,      // 16-bit input (unsigned)
    output logic [7:0] out_hi,  // 8-bit output for upper byte (in[15:8])
    output logic [7:0] out_lo    // 8-bit output for lower byte (in[7:0])
);

always @(*) begin
    out_hi = in[15:8];  // Upper byte of input
    out_lo = in[7:0];   // Lower byte of input
end

endmodule
[DONE]