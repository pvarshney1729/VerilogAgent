[DONE]
```verilog
module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst_n,
    output logic Y1
);

    logic [2:0] state, next_state;

    // Output Logic
    assign Y1 = state[1];

    // State Transition Logic with Synchronous Reset
    always @(posedge clk) begin
        if (!rst_n)
            state <= 3'b000; // Reset to state A
        else
            state <= next_state;
    end

    // Next-State Logic for state transitions
    always @(*) begin
        case (state)
            3'b000: next_state = (w == 1'b0) ? 3'b001 : 3'b000; // State A
            3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State B
            3'b010: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State C
            3'b011: next_state = (w == 1'b0) ? 3'b101 : 3'b000; // State D
            3'b100: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State E
            3'b101: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State F
            default: next_state = 3'b000; // Default to state A
        endcase
    end

endmodule
```