[BEGIN]
module TopModule (
    input logic x,  // Single-bit input signal
    input logic y,  // Single-bit input signal
    output logic z  // Single-bit output signal
);

always @(*) begin
    z = (x ^ y) & x;
end

endmodule
[DONE]