module TopModule (
    input logic clk,          // Clock input
    input logic areset,       // Asynchronous reset, active on positive edge
    input logic bump_left,    // Indicates an obstacle on the left
    input logic bump_right,   // Indicates an obstacle on the right
    input logic ground,       // Indicates presence of ground
    input logic dig,          // Command to start digging
    output logic walk_left,   // Lemming is walking left
    output logic walk_right,  // Lemming is walking right
    output logic aaah,        // Lemming is falling
    output logic digging      // Lemming is digging
);

    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALLING = 3'b010,
        DIGGING = 3'b011,
        SPLATTERED = 3'b100
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter;
    state_t prev_walk_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
            prev_walk_state <= WALK_LEFT;
        end else begin
            state <= next_state;
            if (state == FALLING) begin
                fall_counter <= fall_counter + 5'd1;
            end else begin
                fall_counter <= 5'd0;
            end
            if (state == WALK_LEFT || state == WALK_RIGHT) begin
                prev_walk_state <= state;
            end
        end
    end

    always_comb begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = state;

        case (state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = SPLATTERED;
                    end else begin
                        next_state = prev_walk_state;
                    end
                end
            end

            DIGGING: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end
            end

            SPLATTERED: begin
                // All outputs remain 0
            end
        endcase
    end
endmodule