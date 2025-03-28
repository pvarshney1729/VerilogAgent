module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_IDLE = 3'b000,
        STATE_1    = 3'b001,
        STATE_11   = 3'b010,
        STATE_110  = 3'b011,
        STATE_1101 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_1101)
                start_shifting <= 1'b1;
        end
    end

    // Combinational logic for next state logic
    always_comb begin
        case (current_state)
            STATE_IDLE: 
                if (data) next_state = STATE_1;
                else next_state = STATE_IDLE;
            STATE_1:
                if (data) next_state = STATE_11;
                else next_state = STATE_IDLE;
            STATE_11:
                if (~data) next_state = STATE_110;
                else next_state = STATE_11;
            STATE_110:
                if (data) next_state = STATE_1101;
                else next_state = STATE_IDLE;
            STATE_1101:
                next_state = STATE_1101; // Remain in this state once sequence is detected
            default:
                next_state = STATE_IDLE;
        endcase
    end

endmodule