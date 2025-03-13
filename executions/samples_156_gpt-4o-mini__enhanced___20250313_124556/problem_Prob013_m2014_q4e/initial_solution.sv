module TopModule (
    input logic in1,    // Input signal 1 (1-bit)
    input logic in2,    // Input signal 2 (1-bit)
    output logic out    // Output signal (1-bit)
);

// Behavioral Description
// The TopModule implements a 2-input NOR gate.
assign out = ~(in1 | in2);

endmodule