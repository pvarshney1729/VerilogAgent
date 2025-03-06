module TopModule (
    input logic [5:0] y,   // Input 'y', 6 bits, unsigned, bit[0] is LSB
    input logic w,         // Input 'w', 1 bit, unsigned
    input logic clk,       // Clock signal
    input logic reset,     // Synchronous reset signal
    output logic Y1,       // Output 'Y1', 1 bit, unsigned
    output logic Y3        // Output 'Y3', 1 bit, unsigned
);

    logic [5:0] state, next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            6'b000001: next_state = (w == 1'b0) ? 6'b000010 : 6'b000001; // A to B or stay in A
            6'b000010: next_state = (w == 1'b0) ? 6'b000100 : 6'b001000; // B to C or D
            6'b000100: next_state = (w == 1'b0) ? 6'b010000 : 6'b001000; // C to E or D
            6'b001000: next_state = (w == 1'b0) ? 6'b100000 : 6'b000001; // D to F or A
            6'b010000: next_state = (w == 1'b0) ? 6'b010000 : 6'b001000; // E stays or to D
            6'b100000: next_state = (w == 1'b0) ? 6'b000100 : 6'b001000; // F to C or D
            default:   next_state = 6'b000001; // Default to A
        endcase
    end

    // Sequential logic for state transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= 6'b000001; // Reset to state A
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign Y1 = state[1]; // Y1 is high in state B
    assign Y3 = state[3]; // Y3 is high in state D

endmodule