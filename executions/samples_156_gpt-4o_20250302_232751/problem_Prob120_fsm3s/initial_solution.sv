module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (in) ? STATE_B : STATE_A;
            STATE_B: next_state = (in) ? STATE_B : STATE_C;
            STATE_C: next_state = (in) ? STATE_D : STATE_A;
            STATE_D: next_state = (in) ? STATE_B : STATE_C;
            default: next_state = STATE_A; // Handle undefined states
        endcase
    end

    // Sequential logic for state transition and output
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            out <= (next_state == STATE_D) ? 1'b1 : 1'b0;
        end
    end

endmodule