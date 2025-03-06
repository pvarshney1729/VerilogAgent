module TopModule (
    input logic clk,        // Clock signal
    input logic areset,     // Asynchronous reset, active high
    input logic j,          // Input j
    input logic k,          // Input k
    output logic out        // Output indicating current state
);

// State Encoding
localparam OFF = 1'b0;
localparam ON  = 1'b1;

// State Register
logic current_state, next_state;

// Asynchronous Reset and State Transition Logic
always @(posedge clk) begin
    if (areset) begin
        current_state <= OFF;    // Reset state is OFF
    end else begin
        current_state <= next_state;
    end
end

// Next State Logic
always @(*) begin
    case (current_state)
        OFF: begin
            if (j)
                next_state = ON;   // Transition from OFF to ON if j == 1
            else
                next_state = OFF;  // Remain in OFF if j == 0
        end
        ON: begin
            if (k)
                next_state = OFF;  // Transition from ON to OFF if k == 1
            else
                next_state = ON;   // Remain in ON if k == 0
        end
        default: next_state = OFF; // Default to OFF for safety
    endcase
end

// Output Logic
always @(*) begin
    case (current_state)
        OFF: out = 1'b0;  // Output 0 when in OFF state
        ON:  out = 1'b1;  // Output 1 when in ON state
        default: out = 1'b0; // Default output for undefined states
    endcase
end

endmodule