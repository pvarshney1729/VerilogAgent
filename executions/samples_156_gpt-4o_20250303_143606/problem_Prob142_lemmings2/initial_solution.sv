module TopModule(
    input logic clk,           // Clock signal, positive edge triggered
    input logic areset,        // Asynchronous active-high reset
    input logic bump_left,     // Indicates bump on the left
    input logic bump_right,    // Indicates bump on the right
    input logic ground,        // Indicates presence of ground
    output logic walk_left,    // Lemming walks left when high
    output logic walk_right,   // Lemming walks right when high
    output logic aaah          // Lemming is falling when high
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10
    } state_t;

    state_t current_state, next_state;
    state_t previous_walk_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            previous_walk_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
            if (ground) begin
                previous_walk_state <= next_state;
            end
        end
    end

    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING: begin
                if (ground) begin
                    next_state = previous_walk_state;
                end else begin
                    next_state = FALLING;
                end
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    always_comb begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALLING);
    end

endmodule