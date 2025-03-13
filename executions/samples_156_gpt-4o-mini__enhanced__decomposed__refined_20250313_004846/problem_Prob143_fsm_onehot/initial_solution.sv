module TopModule (
    input logic in,
    input logic [9:0] state,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);
    always @(*) begin
        // Default outputs
        out1 = 0;
        out2 = 0;
        next_state = 10'b0000000000;

        // State transition logic
        if (state[0]) begin
            next_state[0] = (in == 1'b0) ? 1'b1 : 1'b0; // S0 --0--> S0
            next_state[1] = (in == 1'b1) ? 1'b1 : 1'b0; // S0 --1--> S1
        end
        else if (state[1]) begin
            next_state[0] = (in == 1'b0) ? 1'b1 : 1'b0; // S1 --0--> S0
            next_state[2] = (in == 1'b1) ? 1'b1 : 1'b0; // S1 --1--> S2
        end
        else if (state[2]) begin
            next_state[0] = (in == 1'b0) ? 1'b1 : 1'b0; // S2 --0--> S0
            next_state[3] = (in == 1'b1) ? 1'b1 : 1'b0; // S2 --1--> S3
        end
        else if (state[3]) begin
            next_state[0] = (in == 1'b0) ? 1'b1 : 1'b0; // S3 --0--> S0
            next_state[4] = (in == 1'b1) ? 1'b1 : 1'b0; // S3 --1--> S4
        end
        else if (state[4]) begin
            next_state[0] = (in == 1'b0) ? 1'b1 : 1'b0; // S4 --0--> S0
            next_state[5] = (in == 1'b1) ? 1'b1 : 1'b0; // S4 --1--> S5
        end
        else if (state[5]) begin
            next_state[8] = (in == 1'b0) ? 1'b1 : 1'b0; // S5 --0--> S8
            next_state[6] = (in == 1'b1) ? 1'b1 : 1'b0; // S5 --1--> S6
        end
        else if (state[6]) begin
            next_state[9] = (in == 1'b0) ? 1'b1 : 1'b0; // S6 --0--> S9
            next_state[7] = (in == 1'b1) ? 1'b1 : 1'b0; // S6 --1--> S7
        end
        else if (state[7]) begin
            next_state[0] = (in == 1'b0) ? 1'b1 : 1'b0; // S7 --0--> S0
            next_state[7] = (in == 1'b1) ? 1'b1 : 1'b0; // S7 --1--> S7
            out2 = 1; // S7 output
        end
        else if (state[8]) begin
            next_state[0] = (in == 1'b0) ? 1'b1 : 1'b0; // S8 --0--> S0
            next_state[1] = (in == 1'b1) ? 1'b1 : 1'b0; // S8 --1--> S1
            out1 = 1; // S8 output
        end
        else if (state[9]) begin
            next_state[0] = (in == 1'b0) ? 1'b1 : 1'b0; // S9 --0--> S0
            next_state[1] = (in == 1'b1) ? 1'b1 : 1'b0; // S9 --1--> S1
            out1 = 1; // S9 output
            out2 = 1; // S9 output
        end
    end
endmodule