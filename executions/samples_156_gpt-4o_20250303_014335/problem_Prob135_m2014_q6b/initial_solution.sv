module TopModule (
    input logic clk,       // Clock input for synchronous logic
    input logic reset,     // Asynchronous active-high reset
    input logic w,         // 1-bit input for state transition decision
    output logic Y1        // 1-bit output representing y[1]
);

    logic [2:0] state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Initialize to state A
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            3'b000: next_state = (w == 1'b0) ? 3'b001 : 3'b000; // A -> B or A
            3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // B -> C or D
            3'b010: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // C -> E or D
            3'b011: next_state = (w == 1'b0) ? 3'b101 : 3'b000; // D -> F or A
            3'b100: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // E -> E or D
            3'b101: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // F -> C or D
            default: next_state = 3'b000; // Undefined state transitions to A
        endcase
    end

    // Output logic
    assign Y1 = state[1];

endmodule