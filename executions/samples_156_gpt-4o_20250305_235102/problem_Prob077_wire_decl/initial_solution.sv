```verilog
[BEGIN]
module TopModule (
    input logic a,     // 1-bit input
    input logic b,     // 1-bit input
    input logic c,     // 1-bit input
    input logic d,     // 1-bit input
    output logic out,  // 1-bit output
    output logic out_n // 1-bit output (inverted)
);

    logic and_out1, and_out2;

    // Combinational Logic
    always @(*) begin
        and_out1 = a & b;       // AND Gate 1
        and_out2 = c & d;       // AND Gate 2
        out = and_out1 | and_out2; // OR Gate
        out_n = ~out;           // NOT Gate
    end

endmodule
[DONE]
```