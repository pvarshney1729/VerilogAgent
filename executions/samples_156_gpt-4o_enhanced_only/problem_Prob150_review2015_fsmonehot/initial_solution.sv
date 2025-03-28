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

    // Define state encoding for easier reference
    logic S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;
    assign {Wait, Count, B3, B2, B1, B0, S110, S11, S1, S} = state;

    // Next state logic
    always @(*) begin
        S_next = S & ~d | S1 & ~d | S110 & ~d | Wait & ack;
        S1_next = S & d | S1 & d;
        B3_next = B2;
        Count_next = B3 | (Count & ~done_counting);
        Wait_next = Count & done_counting | (Wait & ~ack);

        // Default assignments for unused states
        if (!S && !S1 && !S11 && !S110 && !B0 && !B1 && !B2 && !B3 && !Count && !Wait) begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
    end

    // Output logic
    assign done = Wait;
    assign counting = Count;
    assign shift_ena = B0 | B1 | B2 | B3;

endmodule