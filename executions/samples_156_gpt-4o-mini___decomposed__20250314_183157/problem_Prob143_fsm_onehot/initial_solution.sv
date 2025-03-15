module TopModule (
    input logic in,
    input logic [9:0] state,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);

always @(*) begin
    // Default outputs
    next_state = 10'b0000000000;
    out1 = 1'b0;
    out2 = 1'b0;

    // State transition logic
    if (state[0]) begin // S0
        if (in) next_state[1] = 1'b1; // S1
        else next_state[0] = 1'b1; // S0
    end
    if (state[1]) begin // S1
        if (in) next_state[2] = 1'b1; // S2
        else next_state[0] = 1'b1; // S0
    end
    if (state[2]) begin // S2
        if (in) next_state[3] = 1'b1; // S3
        else next_state[0] = 1'b1; // S0
    end
    if (state[3]) begin // S3
        if (in) next_state[4] = 1'b1; // S4
        else next_state[0] = 1'b1; // S0
    end
    if (state[4]) begin // S4
        if (in) next_state[5] = 1'b1; // S5
        else next_state[0] = 1'b1; // S0
    end
    if (state[5]) begin // S5
        if (in) next_state[6] = 1'b1; // S6
        else next_state[8] = 1'b1; // S8
    end
    if (state[6]) begin // S6
        if (in) next_state[7] = 1'b1; // S7
        else next_state[9] = 1'b1; // S9
    end
    if (state[7]) begin // S7
        out2 = 1'b1; // out2 is set to 1
        if (!in) next_state[0] = 1'b1; // S0
    end
    if (state[8]) begin // S8
        out1 = 1'b1; // out1 is set to 1
        if (in) next_state[1] = 1'b1; // S1
        else next_state[0] = 1'b1; // S0
    end
    if (state[9]) begin // S9
        out1 = 1'b1; // out1 is set to 1
        if (in) next_state[1] = 1'b1; // S1
        else next_state[0] = 1'b1; // S0
    end
end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly