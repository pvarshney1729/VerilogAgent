module TopModule (
    input logic [1:0] A, // 2-bit input, unsigned
    input logic [1:0] B, // 2-bit input, unsigned
    output logic z       // 1-bit output
);

    always_comb begin
        z = (A == B);
    end

endmodule