```verilog
[BEGIN]
module TopModule (
    input logic clk,       // Clock signal, active on the rising edge
    input logic areset,    // Asynchronous reset, active high
    input logic in,        // Input signal
    output logic out       // Output signal
);

    typedef logic state_t; 
    state_t state, next_state;

    // State encoding
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B; // Reset to STATE_B
        end else begin
            state <= next_state; // Update state
        end
    end

    // Next state logic
    always_ff @(state, in) begin
        case (state)
            STATE_A: next_state = (in == 1'b0) ? STATE_B : STATE_A;
            STATE_B: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            default: next_state = STATE_B; // Default case
        endcase
    end

    // Output logic
    always_ff @(state) begin
        out = (state == STATE_B) ? 1'b1 : 1'b0;
    end

endmodule
[DONE]
```