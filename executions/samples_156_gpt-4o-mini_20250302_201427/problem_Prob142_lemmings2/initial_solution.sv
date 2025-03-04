module TopModule (
    input logic clk,           // Clock signal
    input logic areset,        // Asynchronous reset (active high)
    input logic bump_left,     // 1-bit input for left bump detection
    input logic bump_right,    // 1-bit input for right bump detection
    input logic ground,        // 1-bit input indicating ground presence
    output logic walk_left,    // 1-bit output for walking left
    output logic walk_right,   // 1-bit output for walking right
    output logic aaah          // 1-bit output for falling indication
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset to WALK_LEFT state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;

        case (current_state)
            WALK_LEFT: begin
                if (ground == 1'b0) begin
                    next_state = FALL;
                end else if (bump_left == 1'b1 || (bump_left == 1'b1 && bump_right == 1'b1)) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                    walk_left = 1'b1;
                end
            end

            WALK_RIGHT: begin
                if (ground == 1'b0) begin
                    next_state = FALL;
                end else if (bump_right == 1'b1 || (bump_left == 1'b1 && bump_right == 1'b1)) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                    walk_right = 1'b1;
                end
            end

            FALL: begin
                aaah = 1'b1;
                if (ground == 1'b1) begin
                    // Resume last walking direction
                    if (current_state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end else if (current_state == WALK_RIGHT) begin
                        next_state = WALK_RIGHT;
                    end else begin
                        next_state = FALL; // Stay in FALL if no ground
                    end
                end else begin
                    next_state = FALL; // Stay in FALL if no ground
                end
            end

            default: begin
                next_state = WALK_LEFT; // Default state
            end
        endcase
    end

endmodule