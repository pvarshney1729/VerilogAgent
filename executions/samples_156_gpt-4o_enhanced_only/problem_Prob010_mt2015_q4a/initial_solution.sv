module TopModule(
    input logic x,  // 1-bit input
    input logic y,  // 1-bit input
    output logic z  // 1-bit output
);

    // Combinational logic to compute z
    always @(*) begin
        z = (x ^ y) & x;
    end

endmodule