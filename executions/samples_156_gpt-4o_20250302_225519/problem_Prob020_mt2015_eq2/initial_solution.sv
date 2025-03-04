module TopModule (
    input  logic [1:0] A, // 2-bit input, unsigned
    input  logic [1:0] B, // 2-bit input, unsigned
    output logic       z  // 1-bit output, unsigned
);

    // Combinational logic for equality check
    always @(*) begin
        if (A == B)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule