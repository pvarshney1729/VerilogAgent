module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State encoding
    typedef enum logic {
        STATE_B = 1'b0,
        STATE_A = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition and output logic
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

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_B: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            STATE_A: next_state = (in == 1'b0) ? STATE_B : STATE_A;
            default: next_state = STATE_B; // Default to STATE_B for safety
        endcase
    end

endmodule