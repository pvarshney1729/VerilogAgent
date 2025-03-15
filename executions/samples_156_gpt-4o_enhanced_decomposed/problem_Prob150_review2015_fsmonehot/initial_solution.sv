module TopModule(
    input logic d,
    input logic done_counting,
    input logic ack,
    input logic [9:0] state,
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
);

    // Next-state logic
    always @(*) begin
        S_next = (state[0] & ~d) | (state[1] & ~d) | (state[3] & ~d) | (state[9] & ack);
        S1_next = state[0] & d;
        B3_next = state[6];
        Count_next = state[7];
        Wait_next = state[8] & done_counting;
    end

    // Output logic
    always @(*) begin
        shift_ena = state[4] | state[5] | state[6] | state[7];
        counting = state[8];
        done = state[9];
    end

endmodule