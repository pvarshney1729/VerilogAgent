module TopModule (
    input logic a,        // Input signal 'a', 1-bit wide
    input logic b,        // Input signal 'b', 1-bit wide
    output logic out      // Output signal 'out', 1-bit wide
);

    assign out = ~(a ^ b); // XNOR operation

endmodule