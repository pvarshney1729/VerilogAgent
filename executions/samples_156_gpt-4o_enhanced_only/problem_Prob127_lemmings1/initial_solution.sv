module TopModule(
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01
    } state_t;
    
    state_t current_state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT; // Asynchronous reset to WALK_LEFT state
        end else begin
            current_state <= next_state;
        end
    end
    
    // Combinational logic for next state and outputs
    always_comb begin
        // Default assignments
        next_state = current_state;
        walk_left = 0;
        walk_right = 0;
        
        case (current_state)
            WALK_LEFT: begin
                walk_left = 1;
                if (bump_left) begin
                    next_state = WALK_RIGHT;
                end
            end
            WALK_RIGHT: begin
                walk_right = 1;
                if (bump_right) begin
                    next_state = WALK_LEFT;
                end
            end
        endcase
    end

endmodule