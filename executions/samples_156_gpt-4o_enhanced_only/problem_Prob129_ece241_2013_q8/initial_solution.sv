module TopModule(
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // Detected "1"
        S2 = 2'b10  // Detected "10"
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0; // Asynchronous reset to state S0
        else
            state <= next_state;
    end

    // Combinational logic for next state and output logic
    always_comb begin
        // Default assignments
        next_state = state;
        z = 1'b0;

        case (state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Sequence "101" detected
                end else
                    next_state = S0;
            end
        endcase
    end

endmodule