module TopModule (
    input logic x,    // 1-bit input
    input logic y,    // 1-bit input
    output logic z    // 1-bit output
);
    assign z = (x ^ y) & x; // XOR followed by AND logic
endmodule