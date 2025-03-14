module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

logic [4:0] q_reg;

always @(posedge clk) begin
    if (reset) begin
        q_reg <= 5'b00001; // Reset to 1
    end else begin
        q_reg <= {q_reg[3] ^ q_reg[4], q_reg[4:1]}; // Galois LFSR with taps at positions 5 and 3
    end
end

assign q = q_reg;

endmodule