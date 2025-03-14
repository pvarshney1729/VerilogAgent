[BEGIN]
module TopModule (
    input logic in,  // 1-bit input signal
    output logic out  // 1-bit output signal
);

always @(*) begin
    out = in; // Continuous assignment reflecting the value of input
end

endmodule
[DONE]