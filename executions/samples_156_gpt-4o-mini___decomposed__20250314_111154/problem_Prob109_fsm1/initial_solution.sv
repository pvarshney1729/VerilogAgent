module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);
    typedef enum logic {0, 1} state_t; // State encoding for A and B
    state_t state, next_state;

    always @(posedge clk) begin
        if (areset) 
            state <= 1; // Asynchronous reset to state B
        else 
            state <= next_state;
    end

    always @(*) begin
        case (state)
            1: begin // State B
                if (in) 
                    next_state = 1; // Stay in B
                else 
                    next_state = 0; // Transition to A
            end
            0: begin // State A
                if (in) 
                    next_state = 0; // Stay in A
                else 
                    next_state = 1; // Transition to B
            end
            default: next_state = 1; // Default to B
        endcase
    end

    assign out = ~state; // A outputs 0, B outputs 1
endmodule