```
[BEGIN]
module TopModule (
    input logic clk,        // Clock signal, positive edge-triggered
    input logic a,          // 1-bit input
    input logic b,          // 1-bit input
    input logic reset_n,    // Active low synchronous reset
    output logic out_assign,        // 1-bit output for assign-based XOR
    output logic out_always_comb,   // 1-bit output for combinational always block XOR
    output logic out_always_ff       // 1-bit output for sequential always block XOR
);

assign out_assign = a ^ b;

always @(*) begin
    out_always_comb = a ^ b;
end

always @(posedge clk) begin
    if (!reset_n)
        out_always_ff <= 1'b0;
    else
        out_always_ff <= a ^ b;
end

endmodule
[DONE]
```