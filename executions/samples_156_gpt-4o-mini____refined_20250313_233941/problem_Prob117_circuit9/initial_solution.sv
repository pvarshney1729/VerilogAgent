```
[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);
    logic [2:0] state, next_state;

    always @(posedge clk) begin
        state <= next_state;
    end

    always @(*) begin
        case (state)
            3'b000: next_state = a ? 3'b001 : 3'b000; // Transition to state 1 or stay
            3'b001: next_state = a ? 3'b010 : 3'b000; // Transition to state 2 or return to 0
            3'b010: next_state = a ? 3'b011 : 3'b000; // Transition to state 3 or return to 0
            3'b011: next_state = a ? 3'b100 : 3'b000; // Transition to state 4 or return to 0
            3'b100: next_state = a ? 3'b100 : 3'b101; // Stay in state 4 or transition to state 5
            3'b101: next_state = a ? 3'b110 : 3'b000; // Transition to state 6 or return to 0
            3'b110: next_state = a ? 3'b000 : 3'b000; // Transition to state 0 (stay in 0)
            default: next_state = 3'b000; // Default case
        endcase
    end

    assign q = state;

endmodule
[DONE]
```