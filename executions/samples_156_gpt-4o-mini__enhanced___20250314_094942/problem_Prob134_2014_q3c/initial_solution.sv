module TopModule (
    input logic clk,          // Clock signal
    input logic x,           // Input signal (1 bit)
    input logic [2:0] y,     // Input signal (3 bits)
    output logic Y0,         // Output signal (1 bit)
    output logic z           // Output signal (1 bit)
);

// State Encoding
typedef enum logic [2:0] {
    S0 = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    S3 = 3'b011,
    S4 = 3'b100
} state_t;

state_t current_state, next_state;

// Synchronous Reset Behavior
always_ff @(posedge clk) begin
    current_state <= next_state; // Transition to the next state
end

// Next State Logic
always_comb begin
    case (current_state)
        S0: next_state = (x == 0) ? S0 : S1;
        S1: next_state = (x == 0) ? S1 : S4;
        S2: next_state = (x == 0) ? S2 : S1;
        S3: next_state = (x == 0) ? S1 : S2;
        S4: next_state = (x == 0) ? S3 : S4;
        default: next_state = S0; // Handle invalid states
    endcase
end

// Output Logic
always_comb begin
    Y0 = next_state[0]; // Y0 is the least significant bit of the next state
    case (current_state)
        S0: z = 0;
        S1: z = 0;
        S2: z = 0;
        S3: z = 1;
        S4: z = 1;
        default: z = 0; // Default output for invalid states
    endcase
end

endmodule