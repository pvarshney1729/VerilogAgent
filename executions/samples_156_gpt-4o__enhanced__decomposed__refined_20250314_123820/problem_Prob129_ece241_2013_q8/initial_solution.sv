[BEGIN]
module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_IDLE = 2'b00,
        STATE_1    = 2'b01,
        STATE_10   = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition and output logic, synchronous reset
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= STATE_IDLE;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            // Output logic
            z <= (current_state == STATE_10 && x);
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_IDLE: begin
                if (x) 
                    next_state = STATE_1;
                else 
                    next_state = STATE_IDLE;
            end
            STATE_1: begin
                if (!x) 
                    next_state = STATE_10;
                else 
                    next_state = STATE_1;
            end
            STATE_10: begin
                if (x) 
                    next_state = STATE_1;
                else 
                    next_state = STATE_IDLE;
            end
            default: next_state = STATE_IDLE;
        endcase
    end

endmodule
[DONE]