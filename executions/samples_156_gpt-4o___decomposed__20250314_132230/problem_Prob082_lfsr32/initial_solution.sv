module TopModule (
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    logic [31:0] q_reg, q_next;

    // Sequential logic for the LFSR with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            q_reg <= 32'h1;
        end else begin
            q_reg <= q_next;
        end
    end

    // Combinational logic to calculate the next state of the LFSR
    always @(*) begin
        q_next[31] = q_reg[0] ^ q_reg[31]; // Feedback from tap at position 32
        q_next[30] = q_reg[31];
        q_next[29] = q_reg[30];
        q_next[28] = q_reg[29];
        q_next[27] = q_reg[28];
        q_next[26] = q_reg[27];
        q_next[25] = q_reg[26];
        q_next[24] = q_reg[25];
        q_next[23] = q_reg[24];
        q_next[22] = q_reg[0] ^ q_reg[23]; // Feedback from tap at position 22
        q_next[21] = q_reg[22];
        q_next[20] = q_reg[21];
        q_next[19] = q_reg[20];
        q_next[18] = q_reg[19];
        q_next[17] = q_reg[18];
        q_next[16] = q_reg[17];
        q_next[15] = q_reg[16];
        q_next[14] = q_reg[15];
        q_next[13] = q_reg[14];
        q_next[12] = q_reg[13];
        q_next[11] = q_reg[12];
        q_next[10] = q_reg[11];
        q_next[9]  = q_reg[10];
        q_next[8]  = q_reg[9];
        q_next[7]  = q_reg[8];
        q_next[6]  = q_reg[7];
        q_next[5]  = q_reg[6];
        q_next[4]  = q_reg[5];
        q_next[3]  = q_reg[4];
        q_next[2]  = q_reg[0] ^ q_reg[3]; // Feedback from tap at position 2
        q_next[1]  = q_reg[0] ^ q_reg[2]; // Feedback from tap at position 1
        q_next[0]  = q_reg[1];
    end

    // Assign the output
    assign q = q_reg;

endmodule