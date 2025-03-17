module TopModule(
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    logic [4:0] lfsr_reg;
    logic feedback;

    // XOR feedback logic for Galois LFSR with taps at bit positions 5 and 3
    assign feedback = lfsr_reg[0] ^ lfsr_reg[2];

    always_ff @(posedge clk) begin
        if (reset) begin
            lfsr_reg <= 5'b00001; // Reset state
        end else begin
            lfsr_reg <= {feedback, lfsr_reg[4:1]}; // Shift right with feedback
        end
    end

    // Assign the internal register to the output
    assign q = lfsr_reg;

endmodule