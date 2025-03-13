module TopModule (
    input  logic d,
    input  logic done_counting,
    input  logic ack,
    input  logic [9:0] state,
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
);

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default assignments
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        // State transitions
        if (state[0]) begin // S
            if (d) S1_next = 1'b1; // S -> S1
        end else if (state[1]) begin // S1
            if (d) S_next = 1'b1; // S1 -> S11
            else S_next = 1'b1; // S1 -> S
        end else if (state[2]) begin // S11
            if (d) S1_next = 1'b1; // S11 -> S11
            else S_next = 1'b1; // S11 -> S110
        end else if (state[3]) begin // S110
            if (d) B3_next = 1'b1; // S110 -> B0
            else S_next = 1'b1; // S110 -> S
        end else if (state[4]) begin // B0
            shift_ena = 1'b1; // B0 -> B1
        end else if (state[5]) begin // B1
            shift_ena = 1'b1; // B1 -> B2
        end else if (state[6]) begin // B2
            shift_ena = 1'b1; // B2 -> B3
        end else if (state[7]) begin // B3
            shift_ena = 1'b1; // B3 -> Count
        end else if (state[8]) begin // Count
            counting = 1'b1; // Count state
            if (done_counting) Wait_next = 1'b1; // Count -> Wait
        end else if (state[9]) begin // Wait
            done = 1'b1; // Wait state
            if (ack) S_next = 1'b1; // Wait -> S
        end
    end

endmodule