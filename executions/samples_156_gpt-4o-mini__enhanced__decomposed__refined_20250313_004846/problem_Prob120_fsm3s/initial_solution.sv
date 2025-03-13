```
[BEGIN]
module TopModule (
    input logic clk,    // Clock signal, positive edge-triggered
    input logic reset,  // Synchronous active high reset
    input logic in,     // Single-bit input signal
    output logic out    // Single-bit output signal
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                STATE_A: out <= 1'b0;
                STATE_B: out <= 1'b0;
                STATE_C: out <= 1'b0;
                STATE_D: out <= 1'b1;
                default: out <= 1'b0;
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = in ? STATE_B : STATE_A;
            STATE_B: next_state = in ? STATE_B : STATE_C;
            STATE_C: next_state = in ? STATE_D : STATE_A;
            STATE_D: next_state = in ? STATE_B : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

endmodule
[DONE]
```