```verilog
module TopModule (
    input logic clk,          // Clock signal
    input logic reset,        // Synchronous reset signal
    input logic [2:0] y,      // 3-bit unsigned input representing the current state
    input logic w,            // 1-bit input used for state transitions
    output logic Y1           // 1-bit output representing the second bit of the state y
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_A: next_state = (w == 1'b0) ? STATE_B : STATE_A;
            STATE_B: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            STATE_C: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_D: next_state = (w == 1'b0) ? STATE_F : STATE_A;
            STATE_E: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_F: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    assign Y1 = current_state[1];

endmodule
```