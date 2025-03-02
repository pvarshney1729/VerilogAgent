module lfsr_5bit (
    input logic clk,
    input logic reset,
    output logic [4:0] lfsr_out
);

    logic [4:0] lfsr_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            lfsr_reg <= 5'b00001;
        end else begin
            lfsr_reg <= {lfsr_reg[3:0], lfsr_reg[4] ^ lfsr_reg[2]};
        end
    end

    assign lfsr_out = lfsr_reg;

endmodule