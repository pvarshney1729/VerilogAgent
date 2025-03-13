[BEGIN]
module TopModule (
    input  logic clk,              // Clock input signal
    input  logic areset,           // Asynchronous reset signal (active high)
    input  logic bump_left,        // Input signal indicating bump on left (active high)
    input  logic bump_right,       // Input signal indicating bump on right (active high)
    input  logic ground,           // Input signal indicating presence of ground (active high)
    input  logic dig,              // Input signal to initiate digging (active high)
    output logic walk_left,        // Output signal indicating walking left (active high)
    output logic walk_right,       // Output signal indicating walking right (active high)
    output logic aaah,             // Output signal indicating falling (active high)
    output logic digging            // Output signal indicating digging (active high)
);

    typedef enum logic [2:0] {
        WALK_LEFT   = 3'b000,
        WALK_RIGHT  = 3'b001,
        FALLING     = 3'b010,
        DIGGING     = 3'b011,
        SPLATTER    = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // Counter to track fall duration

    // Synchronous reset and state memory
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
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

    // Combinational logic for next state and output logic
    always_comb begin
        // Default output signals
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = current_state;

        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIGGING;
                    digging = 1'b1;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                    walk_right = 1'b1;
                end else begin
                    walk_left = 1'b1;
                end
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIGGING;
                    digging = 1'b1;
                end else if (bump_left) begin
                    next_state = WALK_LEFT;
                    walk_left = 1'b1;
                end else begin
                    walk_right = 1'b1;
                end
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                    end
                end
            end

            DIGGING: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end
            end

            SPLATTER: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end

endmodule
[DONE]