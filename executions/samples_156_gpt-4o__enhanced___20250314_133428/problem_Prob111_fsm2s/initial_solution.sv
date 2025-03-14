```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);

    // State encoding
    typedef enum logic [0:0] {OFF = 1'b0, ON = 1'b1} state_t;
    state_t current_state, next_state;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            out <= current_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            OFF: next_state = (j) ? ON : OFF;
            ON: next_state = (k) ? OFF : ON;
            default: next_state = OFF; // Default to a known state
        endcase
    end

endmodule
```