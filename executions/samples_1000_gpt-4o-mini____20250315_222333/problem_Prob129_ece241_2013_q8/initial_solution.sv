module TopModule (
    input  logic clk,
    input  logic aresetn,
    input  logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after '1'
        S2 = 2'b10  // State after '10'
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state transition
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (x) 
                    next_state = S1; // Move to S1 on '1'
                else 
                    next_state = S0; // Stay in S0 on '0'
            end
            S1: begin
                if (x) 
                    next_state = S1; // Stay in S1 on '1'
                else 
                    next_state = S2; // Move to S2 on '0'
            end
            S2: begin
                if (x) 
                    next_state = S1; // Move to S1 on '1' (overlap)
                else 
                    next_state = S0; // Move to S0 on '0'
            end
            default: next_state = S0; // Default case
        endcase
    end

    // Output logic
    assign z = (current_state == S2 && !x); // Assert z when in S2 and x is '0'

endmodule