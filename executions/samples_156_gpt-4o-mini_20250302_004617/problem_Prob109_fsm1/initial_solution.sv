module moore_fsm (
    input logic clk,
    input logic reset,
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
            STATE_A: next_state = STATE_B;
            STATE_B: next_state = STATE_A;
            default: next_state = STATE_A;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A; // Initialize to STATE_A on reset
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic based on current state
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule