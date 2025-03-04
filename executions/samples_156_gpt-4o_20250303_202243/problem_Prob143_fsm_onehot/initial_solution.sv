module TopModule (
    input logic clk,                   // Clock signal for state transitions
    input logic rst_n,                 // Active-low reset signal
    input logic in,                    // Input signal (1-bit)
    input logic [9:0] state,           // Current state (one-hot encoded, 10 bits)
    output logic [9:0] next_state,     // Next state (one-hot encoded, 10 bits)
    output logic out1,                 // Output signal 1 (1-bit)
    output logic out2                  // Output signal 2 (1-bit)
);

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default assignments
        next_state = 10'b0000000000;
        out1 = 1'b0;
        out2 = 1'b0;

        // Determine next state and outputs based on current state and input
        case (1'b1) // One-hot encoding: only one bit should be set
            state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
            state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1
            state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2
            state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3
            state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4
            state[5]: next_state = in ? 10'b0001000000 : 10'b0000001000; // S5
            state[6]: next_state = in ? 10'b0010000000 : 10'b1000000000; // S6
            state[7]: begin
                next_state = in ? 10'b0100000000 : 10'b0000000001; // S7
                out2 = 1'b1;
            end
            state[8]: begin
                next_state = in ? 10'b0000000010 : 10'b0000000001; // S8
                out1 = 1'b1;
            end
            state[9]: begin
                next_state = in ? 10'b0000000010 : 10'b0000000001; // S9
                out1 = 1'b1;
                out2 = 1'b1;
            end
            default: next_state = 10'b0000000001; // Default to S0 if invalid state
        endcase
    end

    // Sequential logic for state transitions
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            next_state <= 10'b0000000001; // Reset to S0
        end else begin
            next_state <= next_state; // Transition to next state
        end
    end

endmodule