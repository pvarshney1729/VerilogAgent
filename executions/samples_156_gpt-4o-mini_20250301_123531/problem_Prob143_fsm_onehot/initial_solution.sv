module TopModule (
    input logic in,                   // Current input signal
    input logic [9:0] state,          // Current state, one-hot encoded
    output logic [9:0] next_state,     // Next state, one-hot encoded
    output logic out1,                 // Output signal 1
    output logic out2                  // Output signal 2
);

always @(*) begin
    // Default outputs
    out1 = 0;
    out2 = 0;
    next_state = 10'b0000000000;

    // State S0
    if (state[0]) begin
        if (in) next_state[1] = 1; // S0 --1--> S1
        else next_state[0] = 1;    // S0 --0--> S0
    end
    // State S1
    else if (state[1]) begin
        if (in) next_state[2] = 1; // S1 --1--> S2
        else next_state[0] = 1;    // S1 --0--> S0
    end
    // State S2
    else if (state[2]) begin
        if (in) next_state[3] = 1; // S2 --1--> S3
        else next_state[0] = 1;    // S2 --0--> S0
    end
    // State S3
    else if (state[3]) begin
        if (in) next_state[4] = 1; // S3 --1--> S4
        else next_state[0] = 1;    // S3 --0--> S0
    end
    // State S4
    else if (state[4]) begin
        if (in) next_state[5] = 1; // S4 --1--> S5
        else next_state[0] = 1;    // S4 --0--> S0
    end
    // State S5
    else if (state[5]) begin
        if (in) next_state[6] = 1; // S5 --1--> S6
        else next_state[0] = 1;    // S5 --0--> S0
    end
    // State S6
    else if (state[6]) begin
        if (in) next_state[7] = 1; // S6 --1--> S7
        else next_state[0] = 1;    // S6 --0--> S0
    end
    // State S7
    else if (state[7]) begin
        out1 = 1;                   // S7 sets out1
        if (in) next_state[8] = 1; // S7 --1--> S8
        else next_state[0] = 1;    // S7 --0--> S0
    end
    // State S8
    else if (state[8]) begin
        out2 = 1;                   // S8 sets out2
        if (in) next_state[9] = 1; // S8 --1--> S9
        else next_state[0] = 1;    // S8 --0--> S0
    end
    // State S9
    else if (state[9]) begin
        out1 = 1;                   // S9 sets out1
        out2 = 1;                   // S9 sets out2
        next_state[0] = 1;          // S9 --0--> S0
    end
    // Default to S0 if no valid state is active
    else begin
        next_state[0] = 1;          // Default to S0
    end
end

endmodule