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
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL = 2'b10
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (bump_left) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            
            FALL: begin
                if (ground) begin
                    next_state = (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end else begin
                    next_state = FALL;
                end
            end
            
            default: next_state = WALK_LEFT;
        endcase
    end

    assign walk_left = (current_state == WALK_LEFT);
    assign walk_right = (current_state == WALK_RIGHT);
    assign aaah = (current_state == FALL);

endmodule