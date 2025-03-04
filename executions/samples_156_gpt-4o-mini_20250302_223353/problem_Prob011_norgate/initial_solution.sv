module TopModule (
    input logic a,  // 1-bit input signal a
    input logic b,  // 1-bit input signal b
    output logic out // 1-bit output signal out
);

assign out = ~(a | b); // Implementing the NOR gate

endmodule