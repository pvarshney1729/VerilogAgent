module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    typedef enum logic {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (in == 1'b0) ? STATE_B : STATE_A;
            STATE_B: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            default: next_state = STATE_B; // Default to state B
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign out = (current_state == STATE_B) ? 1'b1 : 1'b0;

endmodule