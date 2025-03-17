module TopModule(
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    logic [31:0] q_next;

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= q_next;
        end
    end

    always_comb begin
        q_next[31] = q[0] ^ q[31];
        q_next[30] = q[31];
        q_next[29] = q[30];
        q_next[28] = q[29];
        q_next[27] = q[28];
        q_next[26] = q[27];
        q_next[25] = q[26];
        q_next[24] = q[25];
        q_next[23] = q[24];
        q_next[22] = q[0] ^ q[23];
        q_next[21] = q[22];
        q_next[20] = q[21];
        q_next[19] = q[20];
        q_next[18] = q[19];
        q_next[17] = q[18];
        q_next[16] = q[17];
        q_next[15] = q[16];
        q_next[14] = q[15];
        q_next[13] = q[14];
        q_next[12] = q[13];
        q_next[11] = q[12];
        q_next[10] = q[11];
        q_next[9] = q[10];
        q_next[8] = q[9];
        q_next[7] = q[8];
        q_next[6] = q[7];
        q_next[5] = q[6];
        q_next[4] = q[5];
        q_next[3] = q[4];
        q_next[2] = q[3];
        q_next[1] = q[0] ^ q[2];
        q_next[0] = q[0] ^ q[1];
    end

endmodule