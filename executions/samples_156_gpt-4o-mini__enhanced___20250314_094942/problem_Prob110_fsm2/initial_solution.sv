module TopModule (
    input logic clk,         // Clock signal
    input logic areset,     // Active-high asynchronous reset
    input logic j,          // Input signal for state transition (active high)
    input logic k,          // Input signal for state transition (active high)
    output logic out        // Output signal indicating current state
);

// State encoding
localparam OFF = 1'b0;   // State OFF
localparam ON  = 1'b1;   // State ON

// State variable
logic state, next_state;

// Initial state definition
initial begin
    state = OFF;          // Initial state is OFF
    out = 1'b0;           // Initial output is 0
end

// State transition logic
always @(posedge clk) begin
    if (areset) begin
        state <= OFF;     // Reset state to OFF
        out <= 1'b0;      // Ensure output is 0 on reset
    end else begin
        state <= next_state; // Move to the next state
    end
end

// Next state logic based on current state and inputs
always @(*) begin
    case (state)
        OFF: begin
            if (j) begin
                next_state = ON; // Transition to ON state if j is high
                out = 1'b1;      // Output is 1 in ON state
            end else begin
                next_state = OFF; // Stay in OFF state if j is low
                out = 1'b0;       // Output remains 0
            end
        end
        
        ON: begin
            if (k) begin
                next_state = OFF; // Transition to OFF state if k is high
                out = 1'b0;       // Output is 0 in OFF state
            end else begin
                next_state = ON; // Stay in ON state if k is low
                out = 1'b1;      // Output remains 1
            end
        end
        
        default: begin
            next_state = OFF; // Fallback to OFF state in case of an invalid state
            out = 1'b0;       // Output is reset to 0
        end
    endcase
end

endmodule