module TopModule (
    input  logic in_signal,   // Single-bit input signal
    output logic out_signal   // Single-bit output signal
);

assign out_signal = ~in_signal;

endmodule