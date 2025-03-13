```verilog
module TopModule (
    input logic clk,            // Clock signal (1 bit)
    input logic areset,        // Asynchronous reset (active-high)
    input logic in,            // Input signal (1 bit)
    output logic out           // Output signal (1 bit)
);

// State Encoding
localparam STATE_A = 1'b0;   // State A
localparam STATE_B = 1'b1;   // State B

// State Register
logic current_state;            // Current state of the Moore machine

// Asynchronous Reset and State Transition
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_B; // Reset to State B
    end else begin
        // State transition based on input 'in'
        case (current_state)
            STATE_A: begin
                if (in == 1'b0) 
                    current_state <= STATE_B; // Transition from A to B on '0'
                else 
                    current_state <= STATE_A; // Stay in A on '1'
            end
            STATE_B: begin
                if (in == 1'b0) 
                    current_state <= STATE_A; // Transition from B to A on '0'
                else 
                    current_state <= STATE_B; // Stay in B on '1'
            end
            default: current_state <= STATE_B; // Default case (should not occur)
        endcase
    end
end

// Output Logic
always @(*) begin
    case (current_state)
        STATE_A: out = 1'b0; // Output is 0 in State A
        STATE_B: out = 1'b1; // Output is 1 in State B
        default: out = 1'b0;  // Default output (should not occur)
    endcase
end

endmodule
```