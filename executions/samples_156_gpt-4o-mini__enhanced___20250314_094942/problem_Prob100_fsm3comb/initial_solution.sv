module TopModule (
    input logic in,             // 1-bit input signal (unsigned)
    input logic [1:0] state,   // 2-bit input signal representing the current state
    output logic [1:0] next_state, // 2-bit output signal representing the next state
    output logic out            // 1-bit output signal (unsigned)
);

// State encoding definition
localparam A = 2'b00; // State A
localparam B = 2'b01; // State B
localparam C = 2'b10; // State C
localparam D = 2'b11; // State D

// Combinational logic for next state and output
always @(*) begin
    // Default assignments for output and next_state
    next_state = state; // Default to current state
    out = 0;            // Default output

    case (state)
        A: begin
            if (in) begin
                next_state = B; // Transition from A to B on in=1
            end
        end
        B: begin
            if (in) begin
                next_state = B; // Stay in state B on in=1
            end else begin
                next_state = C; // Transition from B to C on in=0
            end
        end
        C: begin
            if (in) begin
                next_state = D; // Transition from C to D on in=1
            end else begin
                next_state = A; // Transition from C to A on in=0
            end
        end
        D: begin
            if (in) begin
                next_state = B; // Transition from D to B on in=1
            end else begin
                next_state = C; // Transition from D to C on in=0
            end
            out = 1; // Output is 1 in state D
        end
        default: begin
            next_state = A; // Reset to state A
            out = 0;        // Output reset to 0
        end
    endcase
end

endmodule