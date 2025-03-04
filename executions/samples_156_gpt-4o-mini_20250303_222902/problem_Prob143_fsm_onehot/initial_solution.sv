module TopModule (
    input logic in,
    input logic [9:0] state,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);

always @(*) begin
    next_state = 10'b0; // Default to no state
    out1 = 1'b0; // Default output
    out2 = 1'b0; // Default output

    // Determine the highest indexed active state
    if (state[9]) begin // S9
        next_state = (in) ? 10'b0000000001 : 10'b0000000000; // S1 or S0
        out1 = 1'b1;
        out2 = 1'b1;
    end else if (state[8]) begin // S8
        next_state = (in) ? 10'b0000000001 : 10'b0000000000; // S1 or S0
        out1 = 1'b1;
    end else if (state[7]) begin // S7
        next_state = (in) ? 10'b0000000111 : 10'b0000000000; // Stay in S7 or go to S0
    end else if (state[6]) begin // S6
        next_state = (in) ? 10'b0000000110 : 10'b0000000001; // S7 or S1
    end else if (state[5]) begin // S5
        next_state = (in) ? 10'b0000000101 : 10'b0000000000; // S6 or S0
    end else if (state[4]) begin // S4
        next_state = (in) ? 10'b0000000100 : 10'b0000000000; // S5 or S0
    end else if (state[3]) begin // S3
        next_state = (in) ? 10'b0000000011 : 10'b0000000000; // S4 or S0
    end else if (state[2]) begin // S2
        next_state = (in) ? 10'b0000000010 : 10'b0000000000; // S3 or S0
    end else if (state[1]) begin // S1
        next_state = (in) ? 10'b0000000001 : 10'b0000000000; // S2 or S0
    end else if (state[0]) begin // S0
        next_state = (in) ? 10'b0000000001 : 10'b0000000000; // S1 or S0
    end
end

endmodule