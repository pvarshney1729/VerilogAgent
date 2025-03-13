```verilog
[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State Encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B; // Reset state is STATE_B
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always_comb begin
        case (current_state)
            STATE_B: begin
                if (in == 1'b0) 
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B; // Default to reset state for safety
        endcase
    end

    // Output Logic
    always_comb begin
        case (current_state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1; // Default case for safety
        endcase
    end

endmodule
[DONE]
```