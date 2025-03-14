module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    input logic dig,
    output logic walk_left,
    output logic walk_right,
    output logic aaah,
    output logic digging
);

    // State parameters
    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL = 3'b010,
        DIG = 3'b011,
        SPLAT = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // Counter to track falling duration

    // Sequential logic for state transitions
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'b0;
        end else begin
            current_state <= next_state;
            if (current_state == FALL) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'b0;
            end
        end
    end

    // Combinational logic to determine next state
    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = current_state;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (bump_right) next_state = WALK_RIGHT;
                else if (!ground) begin
                    next_state = FALL;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIG;
                    digging = 1'b1;
                end
            end
            
            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (bump_left) next_state = WALK_LEFT;
                else if (!ground) begin
                    next_state = FALL;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIG;
                    digging = 1'b1;
                end
            end
            
            FALL: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter >= 5'd20) begin
                        next_state = SPLAT;
                    end else begin
                        next_state = (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                    end
                end
            end
            
            DIG: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALL;
                    aaah = 1'b1;
                end else begin
                    next_state = (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end
            end
            
            SPLAT: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end

endmodule