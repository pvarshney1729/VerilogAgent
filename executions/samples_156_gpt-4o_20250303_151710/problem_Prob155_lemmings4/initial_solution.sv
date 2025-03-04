module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic areset,        // Asynchronous reset, active high
    input logic bump_left,     // Indicates bump on the left
    input logic bump_right,    // Indicates bump on the right
    input logic ground,        // Indicates if ground is present
    input logic dig,           // Command to start digging
    output logic walk_left,    // Active when walking left
    output logic walk_right,   // Active when walking right
    output logic aaah,         // Active when falling
    output logic digging       // Active when digging
);

    typedef enum logic [2:0] {
        S_WALK_LEFT,
        S_WALK_RIGHT,
        S_FALLING_LEFT,
        S_FALLING_RIGHT,
        S_DIGGING_LEFT,
        S_DIGGING_RIGHT,
        S_SPLATTERED
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == S_FALLING_LEFT || state == S_FALLING_RIGHT) begin
                fall_counter <= fall_counter + 5'd1;
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = state;

        case (state)
            S_WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = S_FALLING_LEFT;
                end else if (dig) begin
                    next_state = S_DIGGING_LEFT;
                end else if (bump_left) begin
                    next_state = S_WALK_RIGHT;
                end
            end
            S_WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = S_FALLING_RIGHT;
                end else if (dig) begin
                    next_state = S_DIGGING_RIGHT;
                end else if (bump_right) begin
                    next_state = S_WALK_LEFT;
                end
            end
            S_FALLING_LEFT: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = S_SPLATTERED;
                    end else begin
                        next_state = S_WALK_LEFT;
                    end
                end
            end
            S_FALLING_RIGHT: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = S_SPLATTERED;
                    end else begin
                        next_state = S_WALK_RIGHT;
                    end
                end
            end
            S_DIGGING_LEFT: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = S_FALLING_LEFT;
                end
            end
            S_DIGGING_RIGHT: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = S_FALLING_RIGHT;
                end
            end
            S_SPLATTERED: begin
                // All outputs remain 0
            end
        endcase
    end

endmodule