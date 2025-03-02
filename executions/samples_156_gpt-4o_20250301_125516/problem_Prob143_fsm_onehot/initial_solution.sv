module TopModule(
    input logic in,
    input logic [9:0] state,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);

always @(*) begin
    // Default values
    next_state = 10'b0000000000;
    out1 = 1'b0;
    out2 = 1'b0;
    
    // State transition and output logic
    case (state)
        10'b0000000001: begin // S0
            if (in == 1'b0) next_state = 10'b0000000010; // Transition to S1
            else next_state = 10'b0000000100; // Transition to S2
        end
        10'b0000000010: begin // S1
            if (in == 1'b0) next_state = 10'b0000000100; // Transition to S2
            else next_state = 10'b0000001000; // Transition to S3
        end
        10'b0000000100: begin // S2
            if (in == 1'b0) next_state = 10'b0000001000; // Transition to S3
            else next_state = 10'b0000010000; // Transition to S4
        end
        10'b0000001000: begin // S3
            if (in == 1'b0) next_state = 10'b0000010000; // Transition to S4
            else next_state = 10'b0000100000; // Transition to S5
        end
        10'b0000010000: begin // S4
            if (in == 1'b0) next_state = 10'b0000100000; // Transition to S5
            else next_state = 10'b0001000000; // Transition to S6
        end
        10'b0000100000: begin // S5
            if (in == 1'b0) next_state = 10'b0001000000; // Transition to S6
            else next_state = 10'b0010000000; // Transition to S7
        end
        10'b0001000000: begin // S6
            if (in == 1'b0) next_state = 10'b0010000000; // Transition to S7
            else next_state = 10'b0100000000; // Transition to S8
        end
        10'b0010000000: begin // S7
            if (in == 1'b0) next_state = 10'b0100000000; // Transition to S8
            else next_state = 10'b1000000000; // Transition to S9
            out1 = 1'b1;
        end
        10'b0100000000: begin // S8
            if (in == 1'b0) next_state = 10'b1000000000; // Transition to S9
            else next_state = 10'b0000000001; // Transition to S0
            out2 = 1'b1;
        end
        10'b1000000000: begin // S9
            if (in == 1'b0) next_state = 10'b0000000001; // Transition to S0
            else next_state = 10'b0000000010; // Transition to S1
            out1 = 1'b1;
            out2 = 1'b1;
        end
        default: begin
            // Undefined state, remain in default state
            next_state = 10'b0000000000;
        end
    endcase
end

endmodule