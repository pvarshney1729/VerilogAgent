module TopModule (
    input logic clk,        // Clock signal, positive edge-triggered
    input logic areset,     // Asynchronous reset, active high
    input logic bump_left,  // Bump detected on the left side
    input logic bump_right, // Bump detected on the right side
    input logic ground,     // Ground presence indicator
    input logic dig,        // Dig command input
    output logic walk_left,  // Walking left indicator
    output logic walk_right, // Walking right indicator
    output logic aaah,       // Falling indicator
    output logic digging     // Digging indicator
);

    typedef enum logic [1:0] {
        Walking_Left = 2'b00,
        Walking_Right = 2'b01,
        Falling = 2'b10,
        Digging = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // Counter for falling state duration

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= Walking_Left;
            fall_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == Falling) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            Walking_Left: begin
                if (ground == 0) begin
                    next_state = Falling;
                end else if (dig == 1) begin
                    next_state = Digging;
                end else if (bump_right == 1) begin
                    next_state = Walking_Right;
                end else begin
                    next_state = Walking_Left;
                end
            end

            Walking_Right: begin
                if (ground == 0) begin
                    next_state = Falling;
                end else if (dig == 1) begin
                    next_state = Digging;
                end else if (bump_left == 1) begin
                    next_state = Walking_Left;
                end else begin
                    next_state = Walking_Right;
                end
            end

            Falling: begin
                if (fall_counter >= 20 && ground == 1) begin
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                end else if (ground == 0) begin
                    next_state = Falling;
                end else begin
                    next_state = Falling;
                end
            end

            Digging: begin
                if (ground == 0) begin
                    next_state = Falling;
                end else begin
                    next_state = Digging;
                end
            end

            default: next_state = Walking_Left;
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == Walking_Left);
        walk_right = (current_state == Walking_Right);
        aaah = (current_state == Falling);
        digging = (current_state == Digging);
    end

endmodule