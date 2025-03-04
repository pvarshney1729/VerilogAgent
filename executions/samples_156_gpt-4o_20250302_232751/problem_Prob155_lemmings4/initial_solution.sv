module TopModule(
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
        FALLING = 3'b010,
        DIGGING = 3'b011,
        SPLATTER = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 5'd0;
        end
    end

    always_comb begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = current_state;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_left || (bump_left && bump_right)) begin
                    next_state = WALK_RIGHT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_right || (bump_left && bump_right)) begin
                    next_state = WALK_LEFT;
                end
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter >= 5'd20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = WALK_LEFT;
                    end
                end
            end

            DIGGING: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end
            end

            SPLATTER: begin
                // All outputs remain 0
            end

            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

endmodule