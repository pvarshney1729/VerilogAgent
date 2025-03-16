module TopModule(
    input logic clk,
    input logic reset,
    output logic [31:0] q
);
    // Internal register to hold the state of the LFSR
    logic [31:0] q_reg;

    always @(posedge clk) begin
        if (reset) begin
            q_reg <= 32'h1; // Synchronous reset to 1
        end else begin
            // Galois LFSR shift with taps at positions 32, 22, 2, and 1
            q_reg <= {q_reg[30:0], (q_reg[31] ^ q_reg[21] ^ q_reg[1] ^ q_reg[0])};
        end
    end

    // Assign the internal register to the output
    assign q = q_reg;

endmodule