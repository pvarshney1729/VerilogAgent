module TopModule (
    input  logic clk,        // Clock input, positive edge triggered
    input  logic reset,      // Reset input, synchronous active high
    input  logic w,          // Input signal for state transitions
    output logic z           // Output signal, active high when in specific states
);

// State encoding
typedef enum logic [2:0] {
    A = 3'b000,
    B = 3'b001,
    C = 3'b010,
    D = 3'b011,
    E = 3'b100,
    F = 3'b101
} state_t;

// State register
state_t current_state, next_state;

// Initial state
initial begin
    current_state = A; // State machine starts in state A
    z = 1'b0;          // Default output
end

// State transition logic
always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= A; // Reset state to A
        z <= 1'b0;          // Reset output
    end else begin
        current_state <= next_state; // Transition to next state
    end
end

// Next state logic
always_comb begin
    case (current_state)
        A: next_state = (w == 1'b0) ? B : A;
        B: next_state = (w == 1'b0) ? C : D;
        C: next_state = (w == 1'b0) ? E : D;
        D: next_state = (w == 1'b0) ? F : A;
        E: next_state = (w == 1'b0) ? E : D;
        F: next_state = (w == 1'b0) ? C : D;
        default: next_state = A; // Default to state A on undefined state
    endcase
end

// Output logic
always_ff @(posedge clk) begin
    case (current_state)
        E: z <= 1'b1; // Assert z when in state E
        default: z <= 1'b0; // Deassert z in all other states
    endcase
end

endmodule