module TopModule (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    next_state = 10'b0000000000; // Default next_state
    out1 = 0; // Default output
    out2 = 0; // Default output
    
    case (1'b1) // Check active states
        state[0]: begin // S0
            if (in) next_state[1] = 1; // to S1
        end
        state[1]: begin // S1
            if (in) next_state[2] = 1; // to S2
            else next_state[0] = 1; // to S0
        end
        state[2]: begin // S2
            if (in) next_state[3] = 1; // to S3
            else next_state[0] = 1; // to S0
        end
        state[3]: begin // S3
            if (in) next_state[4] = 1; // to S4
            else next_state[0] = 1; // to S0
        end
        state[4]: begin // S4
            if (in) next_state[5] = 1; // to S5
            else next_state[0] = 1; // to S0
        end
        state[5]: begin // S5
            if (in) next_state[6] = 1; // to S6
            else next_state[8] = 1; // to S8
        end
        state[6]: begin // S6
            if (in) next_state[7] = 1; // to S7
            else next_state[9] = 1; // to S9
        end
        state[7]: begin // S7
            out2 = 1; // Set out2
            if (in) next_state[7] = 1; // Stay in S7
            else next_state[0] = 1; // to S0
        end
        state[8]: begin // S8
            out1 = 1; // Set out1
            if (in) next_state[1] = 1; // to S1
            else next_state[0] = 1; // to S0
        end
        state[9]: begin // S9
            out1 = 1; // Set out1
            if (in) next_state[1] = 1; // to S1
            else next_state[0] = 1; // to S0
        end
    endcase
end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly