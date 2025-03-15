module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // Received '1'
        S2, // Received '11'
        S3, // Received '110'
        S4  // Received '1101' (sequence found)
    } state_t;

    // State variable
    state_t current_state, next_state;

    // Sequential logic: State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0; // Reset to initial state
            start_shifting <= 1'b0; // Reset output
        end else begin
            current_state <= next_state; // Update state on clock edge
        end
    end

    // Combinational logic: Next state logic
    always @(*) begin
        // Default next state is the current state
        next_state = current_state;
        start_shifting = 1'b0; // Default output

        case (current_state)
            S0: begin
                if (data == 1'b1) 
                    next_state = S1; // Transition to S1 on '1'
            end
            S1: begin
                if (data == 1'b1) 
                    next_state = S2; // Transition to S2 on '1'
                else 
                    next_state = S0; // Reset to S0 on '0'
            end
            S2: begin
                if (data == 1'b0) 
                    next_state = S3; // Transition to S3 on '0'
                else 
                    next_state = S2; // Stay in S2 on '1'
            end
            S3: begin
                if (data == 1'b1) begin
                    next_state = S4; // Transition to S4 on '1'
                    start_shifting = 1'b1; // Signal found
                end else 
                    next_state = S0; // Reset to S0 on '0'
            end
            S4: begin
                // Once in S4, stay there and maintain start_shifting
                start_shifting = 1'b1; // Keep output high
            end
        endcase
    end

endmodule