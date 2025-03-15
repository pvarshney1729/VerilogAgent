module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

logic [4:0] lfsr_reg;
logic feedback;

assign feedback = lfsr_reg[4] ^ lfsr_reg[2]; // Taps at positions 5 (q[4]) and 3 (q[2])
assign q = lfsr_reg;

always @(posedge clk) begin
    if (reset) begin
        lfsr_reg <= 5'b00001; // Reset to 1
    end else begin
        lfsr_reg <= {feedback, lfsr_reg[4:1]}; // Shift right and insert feedback
    end
end

endmodule