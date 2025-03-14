module TopModule (
    input logic a,            // Input signal 'a', 1-bit width, unsigned
    input logic b,            // Input signal 'b', 1-bit width, unsigned
    output logic out          // Output signal 'out', 1-bit width, unsigned
);

// Functionality:
// The module implements a combinational NOR gate. The output 'out' is high if 
// and only if both 'a' and 'b' are low. The logical operation is defined as:
// out = ~(a | b)

assign out = ~(a | b); // Combinational logic assignment

endmodule