module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    output logic walk_left,
    output logic walk_right,
    output logic aaah
);

    typedef enum logic [1:0] {
        WL = 2'b00, // Walking left
        WR = 2'b01, // Walking right
        F  = 2'b10  // Falling
    } state_t;

    state_t current_state, next_state;
    state_t previous_walk_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WL;
            previous_walk_state <= WL;
        end else begin
            current_state <= next_state;
            if (ground) begin
                previous_walk_state <= next_state;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            WL: begin
                if (!ground) begin
                    next_state = F;
                end else if (bump_left) begin
                    next_state = WR;
                end else begin
                    next_state = WL;
                end
            end
            WR: begin
                if (!ground) begin
                    next_state = F;
                end else if (bump_right) begin
                    next_state = WL;
                end else begin
                    next_state = WR;
                end
            end
            F: begin
                if (ground) begin
                    next_state = previous_walk_state;
                end else begin
                    next_state = F;
                end
            end
            default: begin
                next_state = WL;
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == WL);
        walk_right = (current_state == WR);
        aaah = (current_state == F);
    end

endmodule