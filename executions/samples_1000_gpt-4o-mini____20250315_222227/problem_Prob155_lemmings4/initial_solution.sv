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

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'b0;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (bump_right) next_state = WALK_RIGHT;
                else if (!ground) next_state = FALLING;
                else if (dig) next_state = DIGGING;
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (bump_left) next_state = WALK_LEFT;
                else if (!ground) next_state = FALLING;
                else if (dig) next_state = DIGGING;
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20) next_state = SPLATTER;
                    else if (bump_left) next_state = WALK_RIGHT;
                    else if (bump_right) next_state = WALK_LEFT;
                end
            end

            DIGGING: begin
                digging = 1'b1;
                if (!ground) next_state = FALLING;
                else if (bump_left) next_state = WALK_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
            end

            SPLATTER: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end

endmodule