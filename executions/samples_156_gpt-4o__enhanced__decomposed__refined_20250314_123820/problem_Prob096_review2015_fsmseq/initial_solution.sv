[BEGIN]
module TopModule (
    input logic clk,          // Positive-edge triggered clock signal
    input logic reset,        // Active-high synchronous reset signal
    input logic data,         // Input data stream, one bit per clock cycle
    output logic start_shifting // Output signal, set to 1 when sequence 1101 is detected
);

    // State encoding for the FSM
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        FOUND = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state and output register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == FOUND) begin
                start_shifting <= 1'b1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to hold state
        case (current_state)
            IDLE: begin
                if (data) 
                    next_state = S1;
            end
            S1: begin
                if (data) 
                    next_state = S11;
                else 
                    next_state = IDLE;
            end
            S11: begin
                if (!data) 
                    next_state = S110;
            end
            S110: begin
                if (data) 
                    next_state = FOUND;
                else 
                    next_state = IDLE;
            end
            FOUND: begin
                next_state = FOUND; // Stay in FOUND state
            end
            default: begin
                next_state = IDLE; // Default state
            end
        endcase
    end
endmodule
[DONE]