module TopModule (
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    logic [31:0] lfsr_reg, lfsr_next;

    // Sequential logic for LFSR with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            lfsr_reg <= 32'h1;
        end else begin
            lfsr_reg <= lfsr_next;
        end
    end

    // Combinational logic to calculate next state of LFSR
    always_comb begin
        lfsr_next = {lfsr_reg[30:0], lfsr_reg[31] ^ lfsr_reg[0]};
        lfsr_next[21] = lfsr_next[21] ^ lfsr_reg[0];
        lfsr_next[1] = lfsr_next[1] ^ lfsr_reg[0];
        lfsr_next[0] = lfsr_next[0] ^ lfsr_reg[0];
    end

    // Assign the current state to output
    assign q = lfsr_reg;

endmodule