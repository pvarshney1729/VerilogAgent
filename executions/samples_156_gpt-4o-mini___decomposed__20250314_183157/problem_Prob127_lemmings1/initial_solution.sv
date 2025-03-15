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
        LEFT = 2'b00,
        RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            LEFT: begin
                if (bump_right)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            
            RIGHT: begin
                if (bump_left)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            
            default: next_state = LEFT; // default state
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == LEFT);
        walk_right = (current_state == RIGHT);
    end

endmodule