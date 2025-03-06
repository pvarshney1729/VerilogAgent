module TopModule (
    input logic [5:0] y,   // 6-bit input state vector, unsigned, bit[5] is MSB
    input logic w,         // 1-bit input signal
    input logic clk,       // Clock signal
    input logic reset,     // Synchronous reset signal
    output logic Y1,       // 1-bit output
    output logic Y3,       // 1-bit output
    output logic Y2,       // 1-bit next-state signal, derived from y[1]
    output logic Y4        // 1-bit next-state signal, derived from y[3]
);

    logic [5:0] state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= 6'b000001; // Reset to State A
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            6'b000001: next_state = (w == 1'b0) ? 6'b000010 : 6'b000001; // State A
            6'b000010: next_state = (w == 1'b0) ? 6'b000100 : 6'b001000; // State B
            6'b000100: next_state = (w == 1'b0) ? 6'b010000 : 6'b001000; // State C
            6'b001000: next_state = (w == 1'b0) ? 6'b100000 : 6'b000001; // State D
            6'b010000: next_state = (w == 1'b0) ? 6'b010000 : 6'b001000; // State E
            6'b100000: next_state = (w == 1'b0) ? 6'b000100 : 6'b001000; // State F
            default:   next_state = 6'b000001; // Default to State A on invalid state
        endcase
    end

    // Output logic
    always_comb begin
        Y1 = 1'b0; // Define logic for Y1 if needed
        Y3 = 1'b0; // Define logic for Y3 if needed
        Y2 = state[1]; // Derived from y[1] (State B)
        Y4 = state[3]; // Derived from y[3] (State D)
    end

endmodule