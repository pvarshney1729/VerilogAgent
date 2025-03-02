module TopModule (
    input logic clk,             // Clock signal, positive edge-triggered
    input logic areset,          // Asynchronous reset, active high
    input logic bump_left,       // 1-bit input: 1 indicates a bump on the left
    input logic bump_right,      // 1-bit input: 1 indicates a bump on the right
    input logic ground,          // 1-bit input: 1 indicates ground is present
    input logic dig,             // 1-bit input: 1 indicates the command to dig
    output logic walk_left,      // 1-bit output: 1 indicates walking left
    output logic walk_right,     // 1-bit output: 1 indicates walking right
    output logic aaah,           // 1-bit output: 1 indicates falling
    output logic digging         // 1-bit output: 1 indicates digging
);

    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALL = 2'b10,
        DIG = 2'b11
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (dig) begin
                    next_state = DIG;
                end else if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                    walk_left = 1'b1;
                end
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (dig) begin
                    next_state = DIG;
                end else if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                    walk_right = 1'b1;
                end
            end
            FALL: begin
                aaah = 1'b1;
                if (ground) begin
                    next_state = (state == LEFT) ? LEFT : RIGHT;
                end else begin
                    next_state = FALL;
                end
            end
            DIG: begin
                if (!ground) begin
                    next_state = FALL;
                end else begin
                    next_state = DIG;
                    digging = 1'b1;
                end
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end

endmodule