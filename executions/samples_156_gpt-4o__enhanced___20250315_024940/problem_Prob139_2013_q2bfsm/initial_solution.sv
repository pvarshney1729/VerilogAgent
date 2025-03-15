module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    // State declarations
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_F_SET = 2'b01,
        STATE_X_MONITOR = 2'b10,
        STATE_Y_MONITOR = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] x_history; // To store last three x values
    logic f_set;           // Temporary signal to manage f output
    logic g_set;           // Temporary signal to manage g output
    logic y_timer;        // To detect timing for y input

    // Synchronous reset and state transition
    always_ff @(posedge clk) begin
        if (~resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_history <= 3'b000;
            f_set <= 1'b0;
            g_set <= 1'b0;
            y_timer <= 1'b0;
        end else begin
            current_state <= next_state;
            f <= f_set;
            g <= g_set;

            // Update x history
            x_history <= {x_history[1:0], x};
        end
    end

    // State transition logic
    always_comb begin
        next_state = current_state;
        f_set = 1'b0; // Default f output
        g_set = g;    // Default g output remains unchanged

        case (current_state)
            STATE_A: begin
                // On exit from reset state
                if (~resetn) begin
                    next_state = STATE_F_SET;
                    f_set = 1'b1; // Set f for one cycle
                end
            end

            STATE_F_SET: begin
                next_state = STATE_X_MONITOR; // Transition to monitor x
            end

            STATE_X_MONITOR: begin
                // Check if the last three values of x are 1, 0, 1
                if (x_history == 3'b101) begin
                    g_set = 1'b1; // Set g
                    next_state = STATE_Y_MONITOR; // Transition to monitor y
                    y_timer = 3'b00; // Reset y timer
                end
            end

            STATE_Y_MONITOR: begin
                // Monitor y within two clock cycles
                if (y_timer < 2) begin
                    if (y) begin
                        g_set = 1'b1; // Maintain g = 1
                        next_state = STATE_Y_MONITOR; // Stay in this state
                    end else begin
                        y_timer = y_timer + 1; // Increment timer
                        if (y_timer == 2) begin
                            g_set = 1'b0; // Set g to 0 after two cycles
                        end
                    end
                end
            end
        endcase
    end

endmodule