module LemmingFSM (
    input logic clk,             // Clock signal for sequential logic
    input logic areset,          // Asynchronous reset, active high
    input logic bump_left,       // Input signal indicating a bump from the left
    input logic bump_right,      // Input signal indicating a bump from the right
    input logic ground,          // Input signal indicating ground presence
    input logic dig,             // Input signal to command digging
    
    output logic walk_left,      // Output signal indicating walking left
    output logic walk_right,     // Output signal indicating walking right
    output logic aaah,           // Output signal indicating falling
    output logic digging          // Output signal indicating digging
);

    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIGGING,
        SPLATTERED
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // 5 bits to count up to 20

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'b0;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (bump_right) next_state = WALK_RIGHT;
                if (!ground) next_state = FALLING;
                if (dig && ground) next_state = DIGGING;
            end
            
            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (bump_left) next_state = WALK_LEFT;
                if (!ground) next_state = FALLING;
                if (dig && ground) next_state = DIGGING;
            end
            
            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter >= 5'd20) next_state = SPLATTERED;
                    else next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                end
            end
            
            DIGGING: begin
                digging = 1'b1;
                if (!ground) next_state = FALLING;
            end
            
            SPLATTERED: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end
endmodule