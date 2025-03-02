module TopModule (
    input logic clk,
    input logic async_reset_n,
    output logic state
);

    typedef enum logic [0:0] {
        STATE_0 = 1'b0,
        STATE_1 = 1'b1
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset logic
    always_ff @(posedge clk or negedge async_reset_n) begin
        if (!async_reset_n)
            current_state <= STATE_0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_0: next_state = STATE_1;
            STATE_1: next_state = STATE_0;
            default: next_state = STATE_0;
        endcase
    end

    // Output logic
    assign state = current_state;

endmodule