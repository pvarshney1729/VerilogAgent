module lfsr_32bit (
    input logic clk,
    input logic reset,
    output logic [31:0] lfsr_out
);

    logic [31:0] lfsr_reg;

    // Define the tap positions for a 32-bit LFSR
    // Using taps at positions 32, 22, 2, 1 (0-based index: 31, 21, 1, 0)
    logic feedback;

    always_ff @(posedge clk) begin
        if (reset) begin
            lfsr_reg <= 32'h00000001; // Reset value
        end else begin
            feedback = lfsr_reg[31] ^ lfsr_reg[21] ^ lfsr_reg[1] ^ lfsr_reg[0];
            lfsr_reg <= {lfsr_reg[30:0], feedback};
        end
    end

    assign lfsr_out = lfsr_reg;

endmodule