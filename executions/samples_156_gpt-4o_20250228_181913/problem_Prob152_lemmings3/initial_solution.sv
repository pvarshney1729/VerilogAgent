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
    WALK_LEFT = 3'b000,
    WALK_RIGHT = 3'b001,
    FALLING_LEFT = 3'b010,
    FALLING_RIGHT = 3'b011,
    DIGGING_LEFT = 3'b100,
    DIGGING_RIGHT = 3'b101
} state_t;

state_t current_state, next_state;

// Asynchronous reset and state transition logic
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

// Next state logic
always_comb begin
    // Default assignments
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;
    next_state = current_state;

    case (current_state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            if (!ground) begin
                next_state = FALLING_LEFT;
            end else if (dig) begin
                next_state = DIGGING_LEFT;
            end else if (bump_left || bump_right) begin
                next_state = WALK_RIGHT;
            end
        end

        WALK_RIGHT: begin
            walk_right = 1'b1;
            if (!ground) begin
                next_state = FALLING_RIGHT;
            end else if (dig) begin
                next_state = DIGGING_RIGHT;
            end else if (bump_left || bump_right) begin
                next_state = WALK_LEFT;
            end
        end

        FALLING_LEFT: begin
            aaah = 1'b1;
            if (ground) begin
                next_state = WALK_LEFT;
            end
        end

        FALLING_RIGHT: begin
            aaah = 1'b1;
            if (ground) begin
                next_state = WALK_RIGHT;
            end
        end

        DIGGING_LEFT: begin
            digging = 1'b1;
            walk_left = 1'b1;
            if (!ground) begin
                next_state = FALLING_LEFT;
            end
        end

        DIGGING_RIGHT: begin
            digging = 1'b1;
            walk_right = 1'b1;
            if (!ground) begin
                next_state = FALLING_RIGHT;
            end
        end
    endcase
end

endmodule
```