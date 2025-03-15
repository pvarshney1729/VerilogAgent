module TopModule (
    input  logic [7:0] in,   // 8-bit input
    output logic [31:0] out   // 32-bit output
);

    // Combinational logic to sign-extend the 8-bit input to 32 bits
    always @(*) begin
        out = { {24{in[7]}}, in }; // Replicate the sign bit 24 times and concatenate with the input
    end

endmodule