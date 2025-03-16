[BEGIN]
module TopModule (
    input logic a,  // 1-bit input signal
    input logic b,  // 1-bit input signal
    input logic c,  // 1-bit input signal
    output logic out // 1-bit output signal
);

always @(*) begin
    out = (b & c) | (~b & a);
end

endmodule
[DONE]