```verilog
module TopModule(
    input logic a, // One-bit input, unsigned
    input logic b, // One-bit input, unsigned
    input logic c, // One-bit input, unsigned
    input logic d, // One-bit input, unsigned
    output logic q  // One-bit output, unsigned
);

    // Combinational logic for output q
    assign q = (~a & (b | c)) | (a & c);

endmodule
```