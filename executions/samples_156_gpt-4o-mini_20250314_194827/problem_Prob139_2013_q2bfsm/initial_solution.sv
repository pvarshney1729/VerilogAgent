module fsm_detector (
    input logic clk,
    input logic reset,
    input logic x,
    output logic f,
    output logic g
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (x) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (~x) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_C: begin
                if (x) begin
                    next_state = STATE_A; // Reset to A after detecting 1,0,1
                end else begin
                    next_state = STATE_C;
                end
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always @(*) begin
        f = (current_state == STATE_C && x);
        g = (current_state == STATE_C && ~x);
    end

endmodule