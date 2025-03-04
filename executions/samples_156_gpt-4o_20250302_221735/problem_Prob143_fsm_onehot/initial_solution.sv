module TopModule (
    input logic in,              // Single-bit input for state transitions
    input logic [9:0] state,     // 10-bit one-hot encoded current state
    output logic [9:0] next_state,// 10-bit one-hot encoded next state
    output logic out1,            // Single-bit output 1
    output logic out2             // Single-bit output 2
);

always @(*) begin
    next_state = 10'b0000000000; // Default no state
    out1 = 1'b0;
    out2 = 1'b0;

    // State transition logic
    case (1'b1) // One-hot encoding case
        state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001;
        state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001;
        state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001;
        state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001;
        state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001;
        state[5]: next_state = in ? 10'b0001000000 : 10'b0010000000;
        state[6]: next_state = in ? 10'b0100000000 : 10'b1000000000;
        state[7]: begin 
            next_state = in ? 10'b0100000000 : 10'b0000000001;
            out2 = 1'b1;
        end
        state[8]: begin 
            next_state = in ? 10'b0000000010 : 10'b0000000001;
            out1 = 1'b1;
        end
        state[9]: begin 
            next_state = in ? 10'b0000000010 : 10'b0000000001;
            out1 = 1'b1;
            out2 = 1'b1;
        end
        default: next_state = 10'b0000000001; // Default to S0 if no state is active
    endcase
end

endmodule