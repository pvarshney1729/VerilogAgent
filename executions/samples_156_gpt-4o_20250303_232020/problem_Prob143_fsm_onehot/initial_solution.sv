module TopModule (
    input wire in,                       // Single-bit input for state transitions
    input wire [9:0] state,              // 10-bit one-hot encoded current state
    output reg [9:0] next_state,         // 10-bit one-hot encoded next state
    output reg out1,                     // Single-bit output corresponding to FSM output
    output reg out2                      // Single-bit output corresponding to FSM output
);

    always @(*) begin
        // Default assignments
        next_state = 10'b0000000000;
        out1 = 1'b0;
        out2 = 1'b0;

        case (state)
            10'b0000000001: begin // S0
                if (in) next_state = 10'b0000000010; // S1
                else next_state = 10'b0000000001; // S0
            end
            10'b0000000010: begin // S1
                if (in) next_state = 10'b0000000100; // S2
                else next_state = 10'b0000000001; // S0
            end
            10'b0000000100: begin // S2
                if (in) next_state = 10'b0000001000; // S3
                else next_state = 10'b0000000001; // S0
            end
            10'b0000001000: begin // S3
                if (in) next_state = 10'b0000010000; // S4
                else next_state = 10'b0000000001; // S0
            end
            10'b0000010000: begin // S4
                if (in) next_state = 10'b0000100000; // S5
                else next_state = 10'b0000000001; // S0
            end
            10'b0000100000: begin // S5
                if (in) next_state = 10'b0001000000; // S6
                else next_state = 10'b0100000000; // S8
            end
            10'b0001000000: begin // S6
                if (in) next_state = 10'b0010000000; // S7
                else next_state = 10'b1000000000; // S9
            end
            10'b0010000000: begin // S7
                if (in) next_state = 10'b0010000000; // S7
                else next_state = 10'b0000000001; // S0
                out2 = 1'b1;
            end
            10'b0100000000: begin // S8
                if (in) next_state = 10'b0000000010; // S1
                else next_state = 10'b0000000001; // S0
                out1 = 1'b1;
            end
            10'b1000000000: begin // S9
                if (in) next_state = 10'b0000000010; // S1
                else next_state = 10'b0000000001; // S0
                out1 = 1'b1;
                out2 = 1'b1;
            end
            default: begin
                // Undefined state, remain in default state
                next_state = 10'b0000000001; // S0
            end
        endcase
    end

endmodule