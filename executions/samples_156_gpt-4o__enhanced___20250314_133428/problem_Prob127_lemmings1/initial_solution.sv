```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic [1:0] {
        STATE_L = 2'b01,
        STATE_R = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_L: begin
                if (bump_left || bump_right)
                    next_state = STATE_R;
                else
                    next_state = STATE_L;
            end
            STATE_R: begin
                if (bump_right || bump_left)
                    next_state = STATE_L;
                else
                    next_state = STATE_R;
            end
            default: next_state = STATE_L;
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_L;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_L: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            STATE_R: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
```