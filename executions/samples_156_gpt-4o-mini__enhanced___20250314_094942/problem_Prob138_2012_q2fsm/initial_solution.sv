module TopModule (
    input logic clk,         // Clock signal (1-bit)
    input logic reset,       // Synchronous active-high reset signal (1-bit)
    input logic w,           // Input signal (1-bit)
    output logic z           // Output signal (_z_) (1-bit)
);

// State Encoding
typedef enum logic [2:0] {
    A = 3'b000,
    B = 3'b001,
    C = 3'b010,
    D = 3'b011,
    E = 3'b100,
    F = 3'b101
} state_t;

// State Variables
state_t current_state, next_state;

// Sequential Logic: State Flip-Flops
always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= A; // Reset state is A
    end else begin
        current_state <= next_state; // State transition
    end
end

// Combinational Logic: Next State Logic
always_comb begin
    case (current_state)
        A: next_state = (w) ? B : A;
        B: next_state = (w) ? C : D;
        C: next_state = (w) ? E : D;
        D: next_state = (w) ? F : A;
        E: next_state = (w) ? E : D;
        F: next_state = (w) ? C : D;
        default: next_state = A; // Default state
    endcase
end

// Output Logic: FSM Output _z_
always_comb begin
    case (current_state)
        A: z = 0;
        B: z = 0;
        C: z = 0;
        D: z = 0;
        E: z = 1;
        F: z = 1;
        default: z = 0; // Default output state
    endcase
end

endmodule