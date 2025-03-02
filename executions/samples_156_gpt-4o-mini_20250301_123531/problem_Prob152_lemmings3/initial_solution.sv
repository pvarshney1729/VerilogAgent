module TopModule (
    input  logic clk,          // Clock signal: positive edge-triggered
    input  logic areset,       // Asynchronous active high reset
    input  logic bump_left,     // Input: bump sensor on the left
    input  logic bump_right,    // Input: bump sensor on the right
    input  logic ground,        // Input: ground sensor
    input  logic dig,           // Input: dig command
    output logic walk_left,     // Output: high when walking left
    output logic walk_right,    // Output: high when walking right
    output logic aaah,          // Output: high when falling
    output logic digging        // Output: high when digging
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL = 2'b10,
        DIG = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state determination
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (ground && dig) begin
                    next_state = DIG;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (ground && dig) begin
                    next_state = DIG;
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
            
            DIG: begin
                if (!ground) begin
                    next_state = FALL;
                end else begin
                    next_state = DIG;
                end
            end
            
            default: next_state = WALK_LEFT; // Default case
        endcase
    end

    // Output logic based on current state
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            WALK_LEFT: walk_left = 1'b1;
            WALK_RIGHT: walk_right = 1'b1;
            FALL: aaah = 1'b1;
            DIG: digging = 1'b1;
        endcase
    end

endmodule