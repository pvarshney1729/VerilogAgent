```verilog
module TopModule (
    input logic a, // Single-bit input
    input logic b, // Single-bit input
    input logic c, // Single-bit input
    output logic w, // Single-bit output
    output logic x, // Single-bit output
    output logic y, // Single-bit output
    output logic z  // Single-bit output
);

    // Direct connections as per specification
    assign w = a;
    assign x = b;
    assign y = b;
    assign z = c;

endmodule
```