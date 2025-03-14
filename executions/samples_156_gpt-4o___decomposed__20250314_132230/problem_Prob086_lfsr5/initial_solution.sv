module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    logic [4:0] lfsr_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            lfsr_reg <= 5'b00001; // Synchronous reset to set q to 1
        end else begin
            // Implement the Galois LFSR with taps at bit positions 5 and 3
            lfsr_reg <= {lfsr_reg[3:0], lfsr_reg[4] ^ lfsr_reg[2]};
        end
    end

    assign q = lfsr_reg;

endmodule