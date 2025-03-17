module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        S1101 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state; // Default state transition
        start_shifting = 1'b0; // Default output

        case (current_state)
            IDLE: begin
                if (data) next_state = S1;
            end
            S1: begin
                if (data) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (~data) next_state = S110;
            end
            S110: begin
                if (data) next_state = S1101;
                else next_state = IDLE;
            end
            S1101: begin
                start_shifting = 1'b1; // Sequence detected, set output
                // Remain in this state until reset
            end
            default: next_state = IDLE;
        endcase
    end

endmodule