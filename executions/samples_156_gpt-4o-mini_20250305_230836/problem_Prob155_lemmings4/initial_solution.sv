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
        FALL = 3'b010,
        DIG_LEFT = 3'b011,
        DIG_RIGHT = 3'b100,
        SPLATTER = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'b0;
        end else begin
            current_state <= next_state;
            if (current_state == FALL) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_left) next_state = WALK_RIGHT;
                else if (!ground) next_state = FALL;
                else if (dig) next_state = DIG_LEFT;
                else next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_right) next_state = WALK_LEFT;
                else if (!ground) next_state = FALL;
                else if (dig) next_state = DIG_RIGHT;
                else next_state = WALK_RIGHT;
            end
            FALL: begin
                if (ground) begin
                    if (fall_counter >= 5'd20) next_state = SPLATTER;
                    else if (current_state == WALK_LEFT) next_state = WALK_LEFT;
                    else next_state = WALK_RIGHT;
                end else begin
                    next_state = FALL;
                end
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL;
                else if (!dig) next_state = WALK_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL;
                else if (!dig) next_state = WALK_RIGHT;
                else next_state = DIG_RIGHT;
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    assign walk_left = (current_state == WALK_LEFT);
    assign walk_right = (current_state == WALK_RIGHT);
    assign aaah = (current_state == FALL);
    assign digging = (current_state == DIG_LEFT || current_state == DIG_RIGHT);

endmodule