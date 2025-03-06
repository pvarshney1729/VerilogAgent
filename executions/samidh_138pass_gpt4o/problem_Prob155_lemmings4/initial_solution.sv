[BEGIN]
```verilog
module TopModule (
    input logic clk,        // Clock signal, positive edge-triggered
    input logic areset,     // Asynchronous reset signal, active high
    input logic bump_left,  // Bump from the left, active high
    input logic bump_right, // Bump from the right, active high
    input logic ground,     // Ground presence, active high
    input logic dig,        // Dig command, active high
    output logic walk_left, // Walking left indicator
    output logic walk_right, // Walking right indicator
    output logic aaah,      // Falling indicator
    output logic digging    // Digging indicator
);

    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIGGING,
        SPLATTERED
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_count;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 5'd0;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            state <= next_state;
            if (state == FALLING) begin
                fall_count <= fall_count + 5'd1;
            end else begin
                fall_count <= 5'd0;
            end
        end
    end

    always_ff @(state, ground, dig, bump_left, bump_right) begin
        // Default output values
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
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_count > 5'd20) begin
                        next_state = SPLATTERED;
                    end else begin
                        next_state = (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
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
```
[DONE]