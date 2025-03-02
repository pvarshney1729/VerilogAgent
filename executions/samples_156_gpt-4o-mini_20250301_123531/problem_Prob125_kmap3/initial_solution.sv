module TopModule (
    input logic a,    // First input bit
    input logic b,    // Second input bit
    input logic c,    // Third input bit
    input logic d,    // Fourth input bit (don't-care)
    output logic out  // Output bit
);
    assign out = (~c & a) | (c & ~a) | b;
endmodule