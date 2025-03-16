module TopModule (
    input logic clk,       // Clock signal, positive edge-triggered
    input logic areset,    // Asynchronous active-high reset
    input logic x,         // Input signal
    output logic z         // Output signal
);

    // State encoding using one-hot
    typedef enum logic [1:0] {
        STATE_A = 2'b01,
        STATE_B = 2'b10
    } state_t;

    state_t state, next_state;

    // Asynchronous reset and state transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;  // Reset to State A
            z <= 1'b0;         // Output z = 0 when reset
        end else begin
            state <= next_state;  // Transition to next state
        end
    end

    // Next state and output logic
    always_comb begin
        case (state)
            STATE_A: begin
                if (x == 1'b0) begin
                    next_state = STATE_A;
                    z = 1'b0;
                end else begin
                    next_state = STATE_B;
                    z = 1'b1;
                end
            end
            STATE_B: begin
                if (x == 1'b0) begin
                    next_state = STATE_B;
                    z = 1'b1;
                end else begin
                    next_state = STATE_B;
                    z = 1'b0;
                end
            end
            default: begin
                next_state = STATE_A; // Default to state A
                z = 1'b0;
            end
        endcase
    end

endmodule