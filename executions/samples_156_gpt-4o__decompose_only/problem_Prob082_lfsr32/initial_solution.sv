module TopModule (
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    logic [31:0] lfsr_reg, lfsr_next;

    // Sequential logic for LFSR with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            lfsr_reg <= 32'h1; // Reset to 32'h1
        end else begin
            lfsr_reg <= lfsr_next;
        end
    end

    // Combinational logic to calculate the next state of the LFSR
    always @(*) begin
        lfsr_next[31] = lfsr_reg[0] ^ lfsr_reg[31]; // Tap at bit 32
        lfsr_next[30] = lfsr_reg[31];
        lfsr_next[29] = lfsr_reg[30];
        lfsr_next[28] = lfsr_reg[29];
        lfsr_next[27] = lfsr_reg[28];
        lfsr_next[26] = lfsr_reg[27];
        lfsr_next[25] = lfsr_reg[26];
        lfsr_next[24] = lfsr_reg[25];
        lfsr_next[23] = lfsr_reg[24];
        lfsr_next[22] = lfsr_reg[0] ^ lfsr_reg[23]; // Tap at bit 22
        lfsr_next[21] = lfsr_reg[22];
        lfsr_next[20] = lfsr_reg[21];
        lfsr_next[19] = lfsr_reg[20];
        lfsr_next[18] = lfsr_reg[19];
        lfsr_next[17] = lfsr_reg[18];
        lfsr_next[16] = lfsr_reg[17];
        lfsr_next[15] = lfsr_reg[16];
        lfsr_next[14] = lfsr_reg[15];
        lfsr_next[13] = lfsr_reg[14];
        lfsr_next[12] = lfsr_reg[13];
        lfsr_next[11] = lfsr_reg[12];
        lfsr_next[10] = lfsr_reg[11];
        lfsr_next[9]  = lfsr_reg[10];
        lfsr_next[8]  = lfsr_reg[9];
        lfsr_next[7]  = lfsr_reg[8];
        lfsr_next[6]  = lfsr_reg[7];
        lfsr_next[5]  = lfsr_reg[6];
        lfsr_next[4]  = lfsr_reg[5];
        lfsr_next[3]  = lfsr_reg[4];
        lfsr_next[2]  = lfsr_reg[3];
        lfsr_next[1]  = lfsr_reg[0] ^ lfsr_reg[2];  // Tap at bit 2
        lfsr_next[0]  = lfsr_reg[0] ^ lfsr_reg[1];  // Tap at bit 1
    end

    // Assign the current state of the LFSR to the output
    assign q = lfsr_reg;

endmodule