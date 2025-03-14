[BEGIN]
```verilog
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
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIGGING,
        SPLATTER
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'b0;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING) begin
                fall_counter <= fall_counter + 5'b1;
            end else begin
                fall_counter <= 5'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;  // Default to current state
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                end
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_left) begin
                    next_state = WALK_LEFT;
                end
            end

            FALLING: begin
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = (bump_left) ? WALK_RIGHT : (bump_right) ? WALK_LEFT : current_state;
                    end
                end
            end

            DIGGING: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_left || bump_right) begin
                    next_state = DIGGING;
                end else begin
                    next_state = WALK_LEFT; // Default to walking left after digging
                end
            end

            SPLATTER: begin
                next_state = SPLATTER; // Remain in splatter state
            end

            default: next_state = WALK_LEFT; // Default state
        endcase
    end

    // Output logic
    assign walk_left = (current_state == WALK_LEFT);
    assign walk_right = (current_state == WALK_RIGHT);
    assign aaah = (current_state == FALLING);
    assign digging = (current_state == DIGGING);

endmodule
```
[DONE]