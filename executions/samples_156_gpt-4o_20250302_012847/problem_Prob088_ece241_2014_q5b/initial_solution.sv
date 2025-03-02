module mealy_fsm (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    // State encoding using one-hot
    typedef enum logic [1:0] {
        STATE_A = 2'b01,
        STATE_B = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= 2'b00; // Initialize to zero
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            STATE_A: begin
                if (x) begin
                    next_state = STATE_B;
                    z = 1'b1;
                end
            end
            STATE_B: begin
                if (!x) begin
                    next_state = STATE_A;
                    z = 1'b0;
                end else begin
                    z = 1'b1;
                end
            end
            default: begin
                next_state = STATE_A; // Default to STATE_A on invalid state
            end
        endcase
    end

endmodule