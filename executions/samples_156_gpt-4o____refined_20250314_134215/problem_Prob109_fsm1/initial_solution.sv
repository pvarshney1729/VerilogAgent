[BEGIN]
module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic in,
    output logic out
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B; // Default to STATE_B for safety
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (areset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Output logic
    assign out = (current_state == STATE_B);

endmodule
[DONE]