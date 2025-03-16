module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);
    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'b000, // Initial state
        S1 = 3'b001, // Received 1
        S2 = 3'b010, // Received 11
        S3 = 3'b011, // Received 110
        S4 = 3'b100  // Sequence 1101 found
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0; // Reset to initial state
            start_shifting <= 1'b0; // Reset output
        end else begin
            current_state <= next_state; // Update state
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (data) next_state = S1; // Move to S1 on receiving 1
                else next_state = S0; // Stay in S0
            end
            S1: begin
                if (data) next_state = S2; // Move to S2 on receiving 1
                else next_state = S0; // Go back to S0
            end
            S2: begin
                if (!data) next_state = S3; // Move to S3 on receiving 0
                else next_state = S0; // Go back to S0
            end
            S3: begin
                if (data) next_state = S4; // Move to S4 on receiving 1
                else next_state = S0; // Go back to S0
            end
            S4: begin
                next_state = S4; // Stay in S4 once the sequence is found
            end
            default: next_state = S0; // Default to S0
        endcase
    end

    // Output logic
    always @(*) begin
        if (current_state == S4) 
            start_shifting = 1'b1; // Set output high when sequence is found
        else 
            start_shifting = 1'b0; // Otherwise, set output low
    end
endmodule