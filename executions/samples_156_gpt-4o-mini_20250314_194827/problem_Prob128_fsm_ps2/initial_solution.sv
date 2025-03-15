module fsm (
    input logic clk,
    input logic reset,
    input logic input_signal,
    output logic done
);

    typedef enum logic [1:0] {
        STATE_IDLE = 2'b00,
        STATE_PROCESS = 2'b01,
        STATE_DONE = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_IDLE: begin
                if (input_signal) begin
                    next_state = STATE_PROCESS;
                end else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_PROCESS: begin
                next_state = STATE_DONE;
            end
            STATE_DONE: begin
                next_state = STATE_IDLE;
            end
            default: begin
                next_state = STATE_IDLE;
            end
        endcase
    end

    // Done signal logic
    assign done = (current_state == STATE_DONE);

endmodule