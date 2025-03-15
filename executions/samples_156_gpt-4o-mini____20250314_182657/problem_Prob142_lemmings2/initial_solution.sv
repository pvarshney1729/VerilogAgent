module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    output logic walk_left,
    output logic walk_right,
    output logic aaah
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state;
        aaah = 1'b0;
        walk_left = 1'b0;
        walk_right = 1'b0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end
            end

            FALLING: begin
                if (ground) begin
                    if (current_state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end else if (current_state == WALK_RIGHT) begin
                        next_state = WALK_RIGHT;
                    end
                end
            end
        endcase
    end

endmodule