module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);
    // State encoding
    typedef enum logic {Walk_Left, Walk_Right} state_t;
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= Walk_Left;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            Walk_Left: begin
                if (bump_left || (bump_left && bump_right)) begin
                    next_state = Walk_Right;
                end else begin
                    next_state = Walk_Left;
                end
            end
            Walk_Right: begin
                if (bump_right || (bump_left && bump_right)) begin
                    next_state = Walk_Left;
                end else begin
                    next_state = Walk_Right;
                end
            end
            default: next_state = Walk_Left;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            Walk_Left: begin
                walk_left = 1;
                walk_right = 0;
            end
            Walk_Right: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1;
                walk_right = 0;
            end
        endcase
    end
endmodule