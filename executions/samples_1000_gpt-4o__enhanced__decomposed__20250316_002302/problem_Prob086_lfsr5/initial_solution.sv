module TopModule(
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    logic [4:0] lfsr_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            lfsr_reg <= 5'b00001; // Synchronous reset to 1
        end else begin
            lfsr_reg <= {lfsr_reg[3:0], lfsr_reg[4] ^ lfsr_reg[2]}; // Galois LFSR logic
        end
    end

    assign q = lfsr_reg;

endmodule