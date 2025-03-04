module TopModule (
    input wire clk,          // Clock signal, positive edge triggered
    input wire areset,       // Asynchronous reset, active high
    input wire bump_left,    // Trigger to switch from walking left to right
    input wire bump_right,   // Trigger to switch from walking right to left
    output reg walk_left,    // High when Lemming is walking left
    output reg walk_right    // High when Lemming is walking right
);

    // State encoding
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
            default: next_state = STATE_LEFT; // Default to a known state
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            STATE_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule