module galois_lfsr (
    input logic clk,
    input logic reset,
    output logic [31:0] lfsr_out
);

    logic [31:0] lfsr_reg;

    always @(*) begin
        if (reset) begin
            lfsr_reg = 32'b0;
        end else begin
            lfsr_reg = {lfsr_reg[30:0], lfsr_reg[31] ^ lfsr_reg[21] ^ lfsr_reg[1] ^ lfsr_reg[0]};
        end
    end

    always @(posedge clk) begin
        if (!reset) begin
            lfsr_reg <= lfsr_reg;
        end
    end

    assign lfsr_out = lfsr_reg;

endmodule