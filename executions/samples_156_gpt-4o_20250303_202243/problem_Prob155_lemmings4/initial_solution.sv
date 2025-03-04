module TopModule (
    input  logic clk,               // Clock input, positive edge-triggered
    input  logic areset,            // Asynchronous reset, active-high
    input  logic bump_left,         // Lemming bumped on the left, 1-bit
    input  logic bump_right,        // Lemming bumped on the right, 1-bit
    input  logic ground,            // Indicates ground presence, 1-bit
    input  logic dig,               // Command to dig, 1-bit
    output logic walk_left,         // Lemming walking left, 1-bit
    output logic walk_right,        // Lemming walking right, 1-bit
    output logic aaah,              // Lemming falling, 1-bit
    output logic digging            // Lemming digging, 1-bit
);

    typedef enum logic [2:0] {
        WL = 3'b000,  // Walking Left
        WR = 3'b001,  // Walking Right
        F  = 3'b010,  // Falling
        D  = 3'b011,  // Digging
        S  = 3'b100   // Splattered
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == F) begin
                if (ground == 0) 
                    fall_counter <= fall_counter + 1;
                else 
                    fall_counter <= 5'd0;
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            WL: begin
                if (ground == 0)
                    next_state = F;
                else if (dig && ground)
                    next_state = D;
                else if (bump_left)
                    next_state = WR;
                else
                    next_state = WL;
            end
            WR: begin
                if (ground == 0)
                    next_state = F;
                else if (dig && ground)
                    next_state = D;
                else if (bump_right)
                    next_state = WL;
                else
                    next_state = WR;
            end
            F: begin
                if (fall_counter >= 5'd20 && ground)
                    next_state = S;
                else if (ground)
                    next_state = (walk_left) ? WL : WR;
                else
                    next_state = F;
            end
            D: begin
                if (ground == 0)
                    next_state = F;
                else
                    next_state = D;
            end
            S: begin
                next_state = S;
            end
            default: begin
                next_state = WL;
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (state == WL);
        walk_right = (state == WR);
        aaah = (state == F);
        digging = (state == D);
    end

endmodule