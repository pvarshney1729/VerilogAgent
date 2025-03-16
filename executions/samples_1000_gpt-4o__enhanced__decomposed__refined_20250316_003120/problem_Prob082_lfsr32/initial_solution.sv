module TopModule(
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    logic [31:0] lfsr_reg;

    always @(posedge clk) begin
        if (reset) begin
            lfsr_reg <= 32'h1;
        end else begin
            lfsr_reg <= {lfsr_reg[30:0], lfsr_reg[31] ^ lfsr_reg[21] ^ lfsr_reg[1] ^ lfsr_reg[0]};
        end
    end

    assign q = lfsr_reg;

endmodule