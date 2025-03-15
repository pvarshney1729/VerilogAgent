module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    input logic dig,
    output logic walk_left,
    output logic walk_right,
    output logic aaah,
    output logic digging
);

    typedef enum logic [2:0] {
        S_WALK_LEFT = 3'b001,
        S_WALK_RIGHT = 3'b010,
        S_FALLING = 3'b100,
        S_DIGGING = 3'b101,
        S_SPLATTERED = 3'b000
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // Counter to track falling duration

    // State Transition Logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S_WALK_LEFT;
            fall_counter <= 5'b00000;
        end else begin
            current_state <= next_state;
            if (current_state == S_FALLING) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'b00000;
            end
        end
    end

    // Next State Logic
    always_comb begin
        next_state = current_state;

        case (current_state)
            S_WALK_LEFT: begin
                if (!ground) begin
                    next_state = S_FALLING;
                end else if (dig) begin
                    next_state = S_DIGGING;
                end else if (bump_right) begin
                    next_state = S_WALK_RIGHT;
                end
            end
            
            S_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = S_FALLING;
                end else if (dig) begin
                    next_state = S_DIGGING;
                end else if (bump_left) begin
                    next_state = S_WALK_LEFT;
                end
            end
            
            S_FALLING: begin
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = S_SPLATTERED;
                    end else begin
                        next_state = (current_state == S_WALK_LEFT) ? S_WALK_LEFT : S_WALK_RIGHT;
                    end
                end
            end
            
            S_DIGGING: begin
                if (!ground) begin
                    next_state = S_FALLING;
                end else if (ground && !dig) begin
                    next_state = (current_state == S_WALK_LEFT) ? S_WALK_LEFT : S_WALK_RIGHT;
                end
            end
            
            S_SPLATTERED: begin
                // Remain in splattered state
            end
            
            default: begin
                next_state = S_WALK_LEFT; // Default to walking left
            end
        endcase
    end

    // Output Logic
    always_comb begin
        walk_left = (current_state == S_WALK_LEFT);
        walk_right = (current_state == S_WALK_RIGHT);
        aaah = (current_state == S_FALLING);
        digging = (current_state == S_DIGGING);
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly