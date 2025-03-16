module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);
    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // '1' seen
        S2 = 2'b10  // '10' seen
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state transition
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (current_state)
            S0: begin
                z = 1'b0;
                if (x) 
                    next_state = S1; // '1' seen
                else 
                    next_state = S0; // stay in S0
            end
            S1: begin
                z = 1'b0;
                if (!x) 
                    next_state = S2; // '10' seen
                else 
                    next_state = S1; // stay in S1
            end
            S2: begin
                z = 1'b1; // '101' detected
                if (x) 
                    next_state = S1; // '1' seen again
                else 
                    next_state = S0; // reset to S0
            end
            default: begin
                next_state = S0; // default case
                z = 1'b0;
            end
        endcase
    end
endmodule