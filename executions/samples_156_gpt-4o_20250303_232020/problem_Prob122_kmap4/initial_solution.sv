module TopModule (
    input logic a,  // Unsigned 1-bit
    input logic b,  // Unsigned 1-bit
    input logic c,  // Unsigned 1-bit
    input logic d,  // Unsigned 1-bit
    output logic out // Unsigned 1-bit
);

    assign out = (~a & ~b & c & ~d) | 
                 (~a & b & ~c & ~d) | 
                 (a & ~b & ~c & d) | 
                 (a & b & c & ~d);

endmodule