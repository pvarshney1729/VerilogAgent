module galois_lfsr (
    input logic clk,
    input logic reset,
    output logic [4:0] lfsr_out
);

    logic [4:0] lfsr_reg;

    always @(*) begin
        if (reset) begin
            lfsr_reg = 5'b00001;
        end else begin
            lfsr_reg[0] = lfsr_reg[4] ^ lfsr_reg[3]; // Feedback polynomial: x^5 + x^3 + 1
            lfsr_reg[1] = lfsr_reg[0];
            lfsr_reg[2] = lfsr_reg[1];
            lfsr_reg[3] = lfsr_reg[2];
            lfsr_reg[4] = lfsr_reg[3];
        end
    end

    assign lfsr_out = lfsr_reg;

endmodule