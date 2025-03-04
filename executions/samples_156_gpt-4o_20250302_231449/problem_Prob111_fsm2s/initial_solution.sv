```verilog
module TopModule (
    input logic clk,          // Clock input
    input logic reset,        // Active-high synchronous reset
    input logic j,            // Input controlling transition to ON state
    input logic k,            // Input controlling transition to OFF state
    output logic out          // Output reflecting the current state
);

    // Internal state representation
    typedef enum logic {
        STATE_OFF = 1'b0,
        STATE_ON = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_OFF: next_state = j ? STATE_ON : STATE_OFF;
            STATE_ON:  next_state = k ? STATE_OFF : STATE_ON;
        endcase
    end

    // Output logic
    always @(*) begin
        out = (current_state == STATE_ON);
    end

endmodule
```