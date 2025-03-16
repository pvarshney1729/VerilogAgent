[BEGIN]
module TopModule (
    input logic clk,            // Clock signal, assumed positive edge triggered
    input logic areset,         // Asynchronous reset, active high
    input logic bump_left,      // Input signal indicating an obstacle on the left
    input logic bump_right,     // Input signal indicating an obstacle on the right
    output logic walk_left,     // Output signal indicating the Lemming is walking left
    output logic walk_right     // Output signal indicating the Lemming is walking right
);

    // State encoding
    typedef enum logic {
        STATE_LEFT = 1'b0,
        STATE_RIGHT = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
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
                if (bump_left) 
                    next_state = STATE_RIGHT;
                else 
                    next_state = STATE_LEFT;
            end
            STATE_RIGHT: begin
                if (bump_right) 
                    next_state = STATE_LEFT;
                else 
                    next_state = STATE_RIGHT;
            end
            default: next_state = STATE_LEFT;
        endcase
    end

    // Output logic
    always_comb begin
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
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
[END]