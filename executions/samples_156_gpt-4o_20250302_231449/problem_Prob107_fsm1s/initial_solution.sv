```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State Encoding
    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) 
            current_state <= STATE_B;
        else 
            current_state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        case (current_state)
            STATE_B: begin
                out = 1'b1;
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_A: begin
                out = 1'b0;
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: begin
                // Defensive coding practice
                next_state = STATE_B;
                out = 1'b1;
            end
        endcase
    end

endmodule
```