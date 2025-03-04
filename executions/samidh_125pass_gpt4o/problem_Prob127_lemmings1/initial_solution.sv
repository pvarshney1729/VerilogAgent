module TopModule (
    input  logic clk,        // Clock input, positive edge-triggered
    input  logic areset,     // Asynchronous reset, active high
    input  logic bump_left,  // Input signal indicating a left bump
    input  logic bump_right, // Input signal indicating a right bump
    output logic walk_left,  // Output signal indicating walking left
    output logic walk_right  // Output signal indicating walking right
);

    typedef enum logic [0:0] {
        STATE_LEFT  = 1'b0,
        STATE_RIGHT = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_LEFT: begin
                if (bump_left && bump_right)
                    next_state = STATE_RIGHT;
                else if (bump_left)
                    next_state = STATE_RIGHT;
                else
                    next_state = STATE_LEFT;
            end
            STATE_RIGHT: begin
                if (bump_left && bump_right)
                    next_state = STATE_LEFT;
                else if (bump_right)
                    next_state = STATE_LEFT;
                else
                    next_state = STATE_RIGHT;
            end
            default: next_state = STATE_LEFT;
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end else begin
            case (current_state)
                STATE_LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                STATE_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
            endcase
        end
    end

endmodule