module TopModule (
    input logic clk,         // Clock signal, positive edge-triggered
    input logic areset,      // Asynchronous reset, active high
    input logic bump_left,   // Input signal, Lemming hits an obstacle on the left
    input logic bump_right,  // Input signal, Lemming hits an obstacle on the right
    input logic ground,      // Input signal, indicates presence of ground
    input logic dig,         // Input signal, command to dig
    output logic walk_left,  // Output signal, Lemming walking left
    output logic walk_right, // Output signal, Lemming walking right
    output logic aaah,       // Output signal, Lemming falling
    output logic digging     // Output signal, Lemming digging
);

    typedef enum logic [2:0] {
        WL = 3'b000, // Walking Left
        WR = 3'b001, // Walking Right
        DL = 3'b010, // Digging Left
        DR = 3'b011, // Digging Right
        F  = 3'b100  // Falling
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always @(*) begin
        case (current_state)
            WL: begin
                if (!ground)
                    next_state = F;
                else if (dig)
                    next_state = DL;
                else if (bump_left)
                    next_state = WR;
                else
                    next_state = WL;
            end
            WR: begin
                if (!ground)
                    next_state = F;
                else if (dig)
                    next_state = DR;
                else if (bump_right)
                    next_state = WL;
                else
                    next_state = WR;
            end
            DL, DR: begin
                if (!ground)
                    next_state = F;
                else
                    next_state = current_state;
            end
            F: begin
                if (ground)
                    next_state = (current_state == DL || current_state == WL) ? WL : WR;
                else
                    next_state = F;
            end
            default: next_state = WL;
        endcase
    end

    // State Register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WL;
        else
            current_state <= next_state;
    end

    // Output Logic
    always @(*) begin
        walk_left = (current_state == WL || current_state == DL);
        walk_right = (current_state == WR || current_state == DR);
        aaah = (current_state == F);
        digging = (current_state == DL || current_state == DR);
    end

endmodule