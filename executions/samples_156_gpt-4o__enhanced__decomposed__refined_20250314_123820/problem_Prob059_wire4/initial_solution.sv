[BEGIN]
module TopModule (
    input logic a,  // 1-bit input signal
    input logic b,  // 1-bit input signal
    input logic c,  // 1-bit input signal
    output logic w, // 1-bit output signal
    output logic x, // 1-bit output signal
    output logic y, // 1-bit output signal
    output logic z  // 1-bit output signal
);

always_comb begin
    w = a;
    x = b;
    y = b;
    z = c;
end

endmodule
[DONE]