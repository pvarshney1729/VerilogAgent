module TopModule (
    input logic x,  // 1-bit input
    input logic y,  // 1-bit input
    output logic z  // 1-bit output
);

    // Combinational logic to implement z = (x ^ y) & x
    assign z = (x ^ y) & x;

endmodule