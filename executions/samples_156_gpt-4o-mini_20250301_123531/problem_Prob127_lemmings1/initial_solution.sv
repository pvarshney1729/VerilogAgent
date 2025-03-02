module TopModule (
    input logic clk,            // Clock signal, positive edge triggered
    input logic areset,         // Asynchronous active high reset
    input logic bump_left,      // Input signal indicating an obstacle on the left
    input logic bump_right,     // Input signal indicating an obstacle on the right
    output logic walk_left,      // Output signal, high when walking left
    output logic walk_right      // Output signal, high when walking right
);

    typedef enum logic {0, 1} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= 0; // Reset to Walking Left
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            0: begin // Walking Left
                walk_left = 1'b1;
                walk_right = 1'b0;
                if (bump_left || bump_right) begin
                    next_state = 1; // Transition to Walking Right
                end else begin
                    next_state = 0; // Remain Walking Left
                end
            end
            1: begin // Walking Right
                walk_left = 1'b0;
                walk_right = 1'b1;
                if (bump_right || bump_left) begin
                    next_state = 0; // Transition to Walking Left
                end else begin
                    next_state = 1; // Remain Walking Right
                end
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                next_state = 0; // Default state
            end
        endcase
    end
endmodule