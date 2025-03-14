module TopModule (
    input logic in,               
    input logic [9:0] state,     
    output logic [9:0] next_state,
    output logic out1,           
    output logic out2            
);
    always @(*) begin
        // Default values for next state and outputs
        next_state = 10'b0000000001; // Default to S0
        out1 = 0;
        out2 = 0;
        
        // Check for valid one-hot encoding
        if (state == 10'b0000000000 || (state & (state - 1)) != 0) begin
            // Invalid state: default values already set
        end else begin
            // State transitions based on current state and input
            if (state[0]) begin // S0
                if (in) next_state = 10'b0000000010; // S1
            end else if (state[1]) begin // S1
                if (in) next_state = 10'b0000000100; // S2
                else next_state = 10'b0000000001; // S0
            end else if (state[2]) begin // S2
                if (in) next_state = 10'b0000001000; // S3
                else next_state = 10'b0000000001; // S0
            end else if (state[3]) begin // S3
                if (in) next_state = 10'b0000010000; // S4
                else next_state = 10'b0000000001; // S0
            end else if (state[4]) begin // S4
                if (in) next_state = 10'b0000100000; // S5
                else next_state = 10'b0000000001; // S0
            end else if (state[5]) begin // S5
                if (in) next_state = 10'b0001000000; // S6
                else next_state = 10'b0010000000; // S8
            end else if (state[6]) begin // S6
                if (in) next_state = 10'b0100000000; // S7
                else next_state = 10'b1000000000; // S9
            end else if (state[7]) begin // S7
                out2 = 1; // Output when in S7
                if (in) next_state = 10'b0000000111; // S7
                else next_state = 10'b0000000001; // S0
            end else if (state[8]) begin // S8
                out1 = 1; // Output when in S8
                if (in) next_state = 10'b0000000010; // S1
                else next_state = 10'b0000000001; // S0
            end else if (state[9]) begin // S9
                out1 = 1; // Output when in S9
                if (in) next_state = 10'b0000000010; // S1
                else next_state = 10'b0000000001; // S0
            end
        end
    end
endmodule