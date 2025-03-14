[BEGIN]
```verilog
module TopModule (
    input logic [2:0] y,  // State input encoded as 3 bits
    input logic w,        // Single bit input
    input logic reset,    // Asynchronous active-low reset signal
    input logic clk,      // Clock signal
    output logic Y1       // Single bit output reflecting y[1]
);
    logic [2:0] state; // Register to hold the current state
    logic [2:0] next_state; // Register for next state

    // State transition logic for next state
    always @(*) begin
        case (state)
            3'b000: next_state = (w == 1'b0) ? 3'b001 : 3'b000; // State A
            3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State B
            3'b010: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State C
            3'b011: next_state = (w == 1'b0) ? 3'b101 : 3'b000; // State D
            3'b100: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State E
            3'b101: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State F
            default: next_state = state; // Maintain current state for invalid inputs
        endcase
    end

    // Synchronous reset and state update
    always @(posedge clk) begin
        if (!reset) begin
            state <= 3'b000; // Set to initial state A (y = 000) on reset
        end else begin
            state <= next_state; // Update state to next state
        end
    end

    // Output logic
    assign Y1 = state[1]; // Output Y1 is directly assigned to y[1]
endmodule
```
[DONE]