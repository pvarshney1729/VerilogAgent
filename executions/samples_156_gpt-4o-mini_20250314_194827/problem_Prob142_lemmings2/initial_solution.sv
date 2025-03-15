module walking_indicator_fsm (
    input logic clk,
    input logic reset,
    output logic [2:0] indicators
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // State 0: All off
        S1 = 2'b01, // State 1: First indicator on
        S2 = 2'b10, // State 2: Second indicator on
        S3 = 2'b11  // State 3: Third indicator on
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S1; // Loop back to S1
            default: next_state = S0; // Default to state S0
        endcase
    end

    // Output logic
    always @(*) begin
        indicators = 3'b000; // Default all indicators off
        case (current_state)
            S1: indicators = 3'b001; // First indicator on
            S2: indicators = 3'b010; // Second indicator on
            S3: indicators = 3'b100; // Third indicator on
            default: indicators = 3'b000; // All off
        endcase
    end

endmodule