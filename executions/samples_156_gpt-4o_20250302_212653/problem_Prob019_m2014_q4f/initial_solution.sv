module TopModule (
    input wire in1,  // 1-bit input signal
    input wire in2,  // 1-bit input signal
    output wire out  // 1-bit output signal
);

    // Combinational logic: out = in1 AND NOT in2
    assign out = in1 & ~in2;

endmodule