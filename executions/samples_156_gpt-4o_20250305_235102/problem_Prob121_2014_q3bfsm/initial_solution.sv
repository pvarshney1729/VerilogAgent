```verilog
[BEGIN]
module TopModule (
    input logic clk,       // Clock input, positive edge-triggered
    input logic reset,     // Synchronous active-high reset
    input logic x,         // FSM input signal
    output logic z         // FSM output signal
);

    // Internal state signals
    logic [2:0] state;     // Current state of the FSM
    logic [2:0] next_state; // Next state of the FSM

    // State transition logic
    always @(*) begin
        case (state)
            3'b000: next_state = (x) ? 3'b001 : 3'b000;
            3'b001: next_state = (x) ? 3'b100 : 3'b001;
            3'b010: next_state = (x) ? 3'b001 : 3'b010;
            3'b011: next_state = (x) ? 3'b010 : 3'b001;
            3'b100: next_state = (x) ? 3'b100 : 3'b011;
            default: next_state = 3'b000; // Undefined states transition to 000
        endcase
    end

    // Output logic
    always @(*) begin
        z = (state == 3'b011 || state == 3'b100) ? 1'b1 : 1'b0;
    end

    // State register logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Reset state
        end else begin
            state <= next_state;
        end
    end

endmodule
[DONE]
```