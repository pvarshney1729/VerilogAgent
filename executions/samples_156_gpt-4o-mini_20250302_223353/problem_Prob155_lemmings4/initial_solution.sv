module obstacle_avoider (
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
        S_WALK_LEFT,
        S_WALK_RIGHT,
        S_FALLING,
        S_DIGGING,
        S_SPLATTERED
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // 5 bits to count up to 20

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S_WALK_LEFT;
            fall_counter <= 5'b0;
        end else begin
            current_state <= next_state;
            if (current_state == S_FALLING) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            S_WALK_LEFT: begin
                if (bump_left) begin
                    next_state = S_WALK_RIGHT;
                end else if (!ground) begin
                    next_state = S_FALLING;
                end else if (dig && ground) begin
                    next_state = S_DIGGING;
                end
            end
            S_WALK_RIGHT: begin
                if (bump_right) begin
                    next_state = S_WALK_LEFT;
                end else if (!ground) begin
                    next_state = S_FALLING;
                end else if (dig && ground) begin
                    next_state = S_DIGGING;
                end
            end
            S_FALLING: begin
                if (ground && (fall_counter > 5'd20)) begin
                    next_state = S_SPLATTERED;
                end
            end
            S_DIGGING: begin
                if (!ground) begin
                    next_state = S_FALLING;
                end
            end
            S_SPLATTERED: begin
                // Remain in splattered state
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            S_WALK_LEFT: begin
                walk_left = 1'b1;
            end
            S_WALK_RIGHT: begin
                walk_right = 1'b1;
            end
            S_FALLING: begin
                aaah = 1'b1;
            end
            S_DIGGING: begin
                digging = 1'b1;
            end
            S_SPLATTERED: begin
                // All outputs are 0
            end
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly