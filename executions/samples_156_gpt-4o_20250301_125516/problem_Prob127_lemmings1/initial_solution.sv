module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic [1:0] {
        Walk_Left = 2'b01,
        Walk_Right = 2'b10
    } state_t;

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
                if (bump_left || (bump_left && bump_right))
                    next_state = Walk_Right;
                else
                    next_state = Walk_Left;
            end
            Walk_Right: begin
                if (bump_right || (bump_left && bump_right))
                    next_state = Walk_Left;
                else
                    next_state = Walk_Right;
            end
            default: next_state = Walk_Left;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            Walk_Left: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            Walk_Right: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule