[BEGIN]
module TopModule (
    input logic clk,      // Clock signal, active on rising edge
    input logic reset,    // Synchronous active-high reset
    input logic w,        // Input signal for state transitions
    output logic z        // Output signal based on state
);

logic [2:0] current_state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        current_state <= 3'b000; // Reset to State A
    end else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        3'b000: next_state = (w) ? 3'b001 : 3'b000; // A
        3'b001: next_state = (w) ? 3'b010 : 3'b011; // B
        3'b010: next_state = (w) ? 3'b100 : 3'b011; // C
        3'b011: next_state = (w) ? 3'b101 : 3'b000; // D
        3'b100: next_state = (w) ? 3'b100 : 3'b011; // E
        3'b101: next_state = (w) ? 3'b010 : 3'b011; // F
        default: next_state = 3'b000; // Default to state A
    endcase
end

// Output logic
always @(*) begin
    z = (current_state == 3'b100) ? 1'b1 : 1'b0; // State E
end

endmodule
[DONE]