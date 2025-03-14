module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);
    // State encoding
    typedef enum logic [1:0] {S0, S1, S2} state_t;
    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            S0: begin
                next_state = (x) ? S1 : S0; // Transition to S1 on '1'
                z = 0;
            end
            S1: begin
                next_state = (x) ? S2 : S0; // Transition to S2 on '0'
                z = 0;
            end
            S2: begin
                next_state = (x) ? S1 : S0; // Stay in S1 on '1' (overlapping)
                z = 1;                      // Output '1' on detecting '101'
            end
            default: begin
                next_state = S0;           // Default to S0
                z = 0;
            end
        endcase
    end
endmodule