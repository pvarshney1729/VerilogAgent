module TopModule (
    input logic [5:0] y,        // Input state signal (one-hot encoded, unsigned)
    input logic w,              // Input signal for state transitions
    output logic Y1,            // Output signal corresponding to state flip-flop y[1]
    output logic Y3             // Output signal corresponding to state flip-flop y[3]
);

logic [5:0] current_state, next_state;

// Output logic derived from the current state
always @(*) begin
    Y1 = y[1]; // Output Y1 corresponds to state flip-flop y[1]
    Y3 = y[3]; // Output Y3 corresponds to state flip-flop y[3]
end

// Next state logic based on current state and input w
always @(*) begin
    case (y)
        6'b000001: next_state = (w) ? 6'b000010 : 6'b000001; // A
        6'b000010: next_state = (w) ? 6'b000100 : 6'b001000; // B
        6'b000100: next_state = (w) ? 6'b010000 : 6'b001000; // C
        6'b001000: next_state = (w) ? 6'b100000 : 6'b000001; // D
        6'b010000: next_state = (w) ? 6'b010000 : 6'b001000; // E
        6'b100000: next_state = (w) ? 6'b000100 : 6'b001000; // F
        default:   next_state = 6'b000001; // Default to A on error
    endcase
end

endmodule