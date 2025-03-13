```
[BEGIN]
module TopModule (
    input logic clk,            // Clock signal (1-bit)
    input logic reset,          // Active-high synchronous reset (1-bit)
    input logic j,              // Input signal j (1-bit)
    input logic k,              // Input signal k (1-bit)
    output logic out            // Output signal out (1-bit)
);
    
    // State representation
    localparam STATE_OFF = 1'b0; // Output out = 0
    localparam STATE_ON  = 1'b1; // Output out = 1

    logic current_state, next_state;

    // Sequential logic for state transition and output
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_OFF; // Reset to OFF state
            out <= 1'b0;                // Output is 0 in OFF state
        end else begin
            current_state <= next_state; // Update current state
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            STATE_OFF: begin
                if (j) begin
                    next_state = STATE_ON;  // Transition to ON state
                end else begin
                    next_state = STATE_OFF; // Remain in OFF state
                end
            end
            
            STATE_ON: begin
                if (k) begin
                    next_state = STATE_OFF; // Transition to OFF state
                end else begin
                    next_state = STATE_ON;  // Remain in ON state
                end
            end
            
            default: begin
                next_state = STATE_OFF;    // Default case to handle unexpected states
            end
        endcase
    end

    // Output logic based on current state (Moore machine)
    always @(*) begin
        case (current_state)
            STATE_OFF: out = 1'b0; // Output is 0 in OFF state
            STATE_ON: out = 1'b1;  // Output is 1 in ON state
            default: out = 1'b0;    // Default case
        endcase
    end

endmodule
[DONE]
```