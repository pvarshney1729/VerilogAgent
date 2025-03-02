module galois_lfsr (
    input logic clk,
    input logic reset,
    output logic [31:0] lfsr_out
);

    logic [31:0] lfsr_reg;

    // Initialize all flip-flops to zero in simulation
    initial begin
        lfsr_reg = 32'b0;
    end

    // Synchronous reset and LFSR update
    always @(*) begin
        if (reset) begin
            lfsr_reg = 32'b0;
        end else begin
            // Galois LFSR feedback polynomial: x^32 + x^22 + x^21 + x^17 + x^16 + x^15 + x^14 + x^11 + x^10 + x^7 + x^5 + x^4 + x^3 + x^1 + 1
            lfsr_reg = {lfsr_reg[30:0], lfsr_reg[31] ^ lfsr_reg[22] ^ lfsr_reg[21] ^ lfsr_reg[17] ^ lfsr_reg[16] ^ lfsr_reg[15] ^ lfsr_reg[14] ^ lfsr_reg[11] ^ lfsr_reg[10] ^ lfsr_reg[7] ^ lfsr_reg[5] ^ lfsr_reg[4] ^ lfsr_reg[3] ^ lfsr_reg[1]};
        end
    end

    assign lfsr_out = lfsr_reg;

endmodule