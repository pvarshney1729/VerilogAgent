module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_LEFT = 2'b00,
        STATE_RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_LEFT: begin
                if (bump_right || bump_left) begin
                    next_state = STATE_RIGHT;
                end else begin
                    next_state = STATE_LEFT;
                end
            end
            
            STATE_RIGHT: begin
                if (bump_left || bump_right) begin
                    next_state = STATE_LEFT;
                end else begin
                    next_state = STATE_RIGHT;
                end
            end
            
            default: next_state = STATE_LEFT;
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == STATE_LEFT);
        walk_right = (current_state == STATE_RIGHT);
    end

endmodule