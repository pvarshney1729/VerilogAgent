[BEGIN]
module TopModule (
    input  logic clk,    // Clock input
    input  logic reset,  // Active-high synchronous reset
    input  logic j,      // Input signal j
    input  logic k,      // Input signal k
    output logic out     // Output signal out
);

    // State declarations
    typedef enum logic {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    // State register
    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;  // Reset to OFF state
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        unique case (current_state)
            OFF: next_state = j ? ON : OFF;  // Transition from OFF
            ON:  next_state = k ? OFF : ON;  // Transition from ON
        endcase
    end

    // Output logic
    always @(*) begin
        unique case (current_state)
            OFF: out = 1'b0;   // Output for OFF state
            ON:  out = 1'b1;   // Output for ON state
        endcase
    end

endmodule
[DONE]