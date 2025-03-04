```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_B; // Handle illegal states
        endcase
    end

    // State register and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B;
            out <= 1'b1;
        end else begin
            current_state <= next_state;
            case (next_state)
                STATE_B: out <= 1'b1;
                STATE_A: out <= 1'b0;
            endcase
        end
    end

endmodule
```