module TopModule (
    input  logic in_signal,  // Input: 1-bit unsigned
    output logic out_signal  // Output: 1-bit unsigned
);

// Combinational logic: direct wire assignment
assign out_signal = in_signal;

endmodule