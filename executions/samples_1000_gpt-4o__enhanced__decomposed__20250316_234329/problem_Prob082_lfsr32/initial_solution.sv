module TopModule (
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    logic [31:0] lfsr_state;
    logic [31:0] next_q;

    // Combinational logic to calculate the next state
    always @(*) begin
        next_q[31] = lfsr_state[0]; // Shift right and feedback from q[0]
        next_q[30] = lfsr_state[31];
        next_q[29] = lfsr_state[30];
        next_q[28] = lfsr_state[29];
        next_q[27] = lfsr_state[28];
        next_q[26] = lfsr_state[27];
        next_q[25] = lfsr_state[26];
        next_q[24] = lfsr_state[25];
        next_q[23] = lfsr_state[24];
        next_q[22] = lfsr_state[23] ^ lfsr_state[0]; // Tap at position 22
        next_q[21] = lfsr_state[22];
        next_q[20] = lfsr_state[21];
        next_q[19] = lfsr_state[20];
        next_q[18] = lfsr_state[19];
        next_q[17] = lfsr_state[18];
        next_q[16] = lfsr_state[17];
        next_q[15] = lfsr_state[16];
        next_q[14] = lfsr_state[15];
        next_q[13] = lfsr_state[14];
        next_q[12] = lfsr_state[13];
        next_q[11] = lfsr_state[12];
        next_q[10] = lfsr_state[11];
        next_q[9]  = lfsr_state[10];
        next_q[8]  = lfsr_state[9];
        next_q[7]  = lfsr_state[8];
        next_q[6]  = lfsr_state[7];
        next_q[5]  = lfsr_state[6];
        next_q[4]  = lfsr_state[5];
        next_q[3]  = lfsr_state[4];
        next_q[2]  = lfsr_state[3] ^ lfsr_state[0]; // Tap at position 2
        next_q[1]  = lfsr_state[2] ^ lfsr_state[0]; // Tap at position 1
        next_q[0]  = lfsr_state[1] ^ lfsr_state[0]; // Tap at position 0 (feedback)
    end

    // Sequential logic with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            lfsr_state <= 32'h1;
        end else begin
            lfsr_state <= next_q;
        end
    end

    // Assign the output
    assign q = lfsr_state;

endmodule