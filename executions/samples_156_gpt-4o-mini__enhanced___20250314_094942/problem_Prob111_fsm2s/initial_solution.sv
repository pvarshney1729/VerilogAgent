module TopModule (
    input logic clk,         // Clock signal (1 bit)
    input logic reset,       // Reset signal (1 bit, active-high)
    input logic j,          // Input signal j (1 bit)
    input logic k,          // Input signal k (1 bit)
    output logic out         // Output signal out (1 bit)
);

// State Encoding
localparam OFF = 1'b0;  // State OFF represented by binary 0
localparam ON  = 1'b1;  // State ON represented by binary 1

// State Variable
logic current_state;      // Current state of the state machine

// Initial State
initial begin
    current_state = OFF; // Initial state is OFF
    out = 1'b0;          // Initial output is 0
end

// Synchronous Reset and State Transition Logic
always @(*) begin
    if (reset) begin
        current_state = OFF; // Reset to OFF state
        out = 1'b0;          // Output is 0 when reset
    end else begin
        case (current_state)
            OFF: begin
                if (j) begin
                    current_state = ON; // Transition to ON state
                    out = 1'b1;         // Output is 1 when in ON state
                end
                // Remain in OFF state when j=0
            end
            
            ON: begin
                if (k) begin
                    current_state = OFF; // Transition to OFF state
                    out = 1'b0;          // Output is 0 when in OFF state
                end
                // Remain in ON state when k=0
            end
            
            default: begin
                current_state = OFF; // Default state in case of unknown state
                out = 1'b0;          // Default output
            end
        endcase
    end
end

endmodule