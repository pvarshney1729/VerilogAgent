module TopModule (
    input logic clk,          // Clock signal for synchronous operations
    input logic reset,        // Active-high synchronous reset
    input logic j,            // Input signal for state transition
    input logic k,            // Input signal for state transition
    output logic out          // Output signal reflecting current state
);
    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            out <= current_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF; // Default case to avoid latches
            end
        endcase
    end
endmodule