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
    
    // Output logic
    always @(*) begin
        z = 1'b0; // Default output
        case (current_state)
            S2: if (x) z = 1'b1; // Output high when in S2 and x is '1'
            default: z = 1'b0;
        endcase
    end

    // State transition logic
    always @ (posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0; // Asynchronous reset to initial state
        end else begin
            current_state <= next_state; // Update state on clock edge
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (x) ? S1 : S0; // Move to S1 on '1'
            S1: next_state = (x) ? S1 : S2; // Stay in S1 on '1', move to S2 on '0'
            S2: next_state = (x) ? S1 : S0; // Move to S1 on '1', reset to S0 on '0'
            default: next_state = S0; // Default case
        endcase
    end

endmodule