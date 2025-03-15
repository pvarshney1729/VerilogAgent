module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);
    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after '1'
        S2 = 2'b10  // State after '10'
    } state_t;
    
    state_t current_state, next_state;

    // Asynchronous reset and state transition
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = current_state;
        z = 1'b0; // Default output

        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (!x) begin
                    next_state = S2;
                end
            end
            S2: begin
                if (x) begin
                    z = 1'b1; // Output asserted for '101'
                    next_state = S1; // Overlapping sequence
                end else begin
                    next_state = S0; // Go back to initial state
                end
            end
        endcase
    end
endmodule