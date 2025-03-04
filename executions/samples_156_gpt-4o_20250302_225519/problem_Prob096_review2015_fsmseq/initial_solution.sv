module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic reset,        // Synchronous active-high reset
    input logic data,         // Input data stream, 1 bit
    output logic start_shifting // Output signal, 1 bit
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        FOUND = 3'b100
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

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            IDLE: begin
                if (data) next_state = S1;
            end
            S1: begin
                if (data) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (!data) next_state = S110;
            end
            S110: begin
                if (data) next_state = FOUND;
                else next_state = IDLE;
            end
            FOUND: begin
                // Remain in FOUND state
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else if (current_state == FOUND) begin
            start_shifting <= 1'b1;
        end
    end

endmodule