module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            LEFT: begin
                if (bump_right) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (bump_left) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            default: next_state = LEFT; // Default state
        endcase
    end

    // State update logic with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);

endmodule