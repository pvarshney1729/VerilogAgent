module TopModule (
    input logic in,  // Single bit input signal.
    output logic out // Single bit output signal.
);

// Combinational Logic:
// The output is always equal to the input. This is a direct, continuous assignment.
assign out = in;

endmodule