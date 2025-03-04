module TopModule (
    input logic a,  // Single-bit input 'a'
    input logic b,  // Single-bit input 'b'
    output logic out // Single-bit output 'out', representing the NOR of 'a' and 'b'
);

    // Behavioral Description:
    // The output 'out' is the NOR operation of inputs 'a' and 'b'.
    // Logical operation: out = ~(a | b)
    
    assign out = ~(a | b);

endmodule