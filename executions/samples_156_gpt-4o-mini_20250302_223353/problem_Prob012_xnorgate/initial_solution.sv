module TopModule(
    input logic a,  // Input port 'a', 1-bit, unsigned
    input logic b,  // Input port 'b', 1-bit, unsigned
    output logic out // Output port 'out', 1-bit, unsigned
);
    assign out = ~(a ^ b); // XNOR operation
endmodule