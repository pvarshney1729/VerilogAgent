module TopModule (
    input logic in_signal,  // Input: Single-bit signal
    output logic out_signal // Output: Single-bit signal reflecting in_signal
);

    // Combinational logic to directly connect input to output
    assign out_signal = in_signal;

endmodule