module TopModule (
    input logic clk,             // Clock input (1-bit)
    input logic aresetn,        // Active low asynchronous reset (1-bit)
    input logic x,              // Input signal (1-bit)
    output logic z              // Output signal indicating "101" sequence detected (1-bit)
);

// State Definitions
typedef enum logic [1:0] {
    S0, // Initial state, looking for '1'
    S1, // First '1' detected, looking for '0'
    S2  // '10' detected, looking for second '1'
} state_t;

// State Variables
state_t current_state, next_state;

// State Initialization
initial begin
    current_state = S0; // Start in state S0
    z = 1'b0;           // Output is low initially
end

// Asynchronous Reset Behavior
always @(negedge aresetn) begin
    current_state <= S0; // Reset to initial state S0
    z <= 1'b0;           // Reset output to low
end

// State Transition Logic
always @(posedge clk) begin
    current_state <= next_state; // Update current state on clock edge
end

// Next State Logic
always @* begin
    case (current_state)
        S0: begin
            if (x == 1'b1) begin
                next_state = S1; // Move to S1 on '1'
            end else begin
                next_state = S0; // Remain in S0 on '0'
            end
            z = 1'b0; // Output low in state S0
        end

        S1: begin
            if (x == 1'b0) begin
                next_state = S2; // Move to S2 on '0'
            end else begin
                next_state = S1; // Remain in S1 on '1'
            end
            z = 1'b0; // Output low in state S1
        end

        S2: begin
            if (x == 1'b1) begin
                next_state = S1; // Detected '1', go back to S1
                z = 1'b1; // Output high when '101' detected
            end else begin
                next_state = S0; // Reset to S0 on '0'
                z = 1'b0; // Output low in state S2
            end
        end

        default: begin
            next_state = S0; // Default to state S0
            z = 1'b0; // Output low in default case
        end
    endcase
end

endmodule