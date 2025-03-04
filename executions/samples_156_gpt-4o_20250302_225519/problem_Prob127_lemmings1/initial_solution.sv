module TopModule (
    input wire clk,          // Clock signal, positive edge triggered
    input wire areset,       // Asynchronous reset signal, active high
    input wire bump_left,    // Input signal, active high
    input wire bump_right,   // Input signal, active high
    output reg walk_left,    // Output signal, active high
    output reg walk_right    // Output signal, active high
);

    // State encoding
    localparam WALK_LEFT = 1'b0;
    localparam WALK_RIGHT = 1'b1;

    // State register
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            default: next_state = WALK_LEFT; // Default to initial state
        endcase
    end

    // State register update logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            WALK_RIGHT: begin
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