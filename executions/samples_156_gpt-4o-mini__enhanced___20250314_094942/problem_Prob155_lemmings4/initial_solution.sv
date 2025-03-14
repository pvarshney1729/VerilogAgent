module TopModule(
    input logic clk,                 // Clock input (positive edge triggered)
    input logic areset,             // Asynchronous active high reset
    input logic bump_left,          // Input: Bump from the left (1 bit)
    input logic bump_right,         // Input: Bump from the right (1 bit)
    input logic ground,             // Input: Ground presence (1 bit, 1 = present)
    input logic dig,                // Input: Dig command (1 bit, 1 = dig)
    output logic walk_left,         // Output: Walking left (1 bit, 1 = walk left)
    output logic walk_right,        // Output: Walking right (1 bit, 1 = walk right)
    output logic aaah,              // Output: Falling state (1 bit, 1 = falling)
    output logic digging             // Output: Digging state (1 bit, 1 = digging)
);

    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALLING = 3'b010,
        DIGGING = 3'b011,
        SPLATTERED = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // 5 bits to count up to 20

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
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIGGING;
                end else begin
                    next_state = WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIGGING;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = SPLATTERED;
                    end else if (current_state == FALLING) begin
                        if (walk_left) begin
                            next_state = WALK_LEFT;
                        end else if (walk_right) begin
                            next_state = WALK_RIGHT;
                        end
                    end
                end else begin
                    next_state = FALLING;
                end
            end

            DIGGING: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else begin
                    next_state = DIGGING;
                end
            end

            SPLATTERED: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
                if (areset) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = SPLATTERED;
                end
            end

            default: next_state = WALK_LEFT; // Fallback to a known state
        endcase
    end

endmodule