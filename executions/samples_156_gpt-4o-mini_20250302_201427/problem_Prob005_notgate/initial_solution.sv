module TopModule(
    logic in,   // 1-bit input signal, unsigned
    logic out   // 1-bit output signal, unsigned
);

assign out = ~in;

endmodule