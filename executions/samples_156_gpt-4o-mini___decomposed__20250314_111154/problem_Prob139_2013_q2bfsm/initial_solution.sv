module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);
    // State encoding
    typedef enum logic [2:0] {
        STATE_A, // Beginning state
        STATE_B, // After reset, f = 1
        STATE_C, // Monitoring x
        STATE_D, // Monitoring y
        STATE_E  // g = 1
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter; // Counter for tracking clock cycles

    // State transition
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic and next state logic
    always_comb begin
        f = 0;
        g = 0;
        next_state = current_state;

        case (current_state)
            STATE_A: begin
                f = 1; // Set f to 1 for one clock cycle
                next_state = STATE_B; // Move to STATE_B
            end
            
            STATE_B: begin
                f = 0; // Reset f after one clock cycle
                next_state = STATE_C; // Move to STATE_C to monitor x
            end
            
            STATE_C: begin
                if (x) begin
                    next_state = STATE_D; // Move to STATE_D if x is 1
                end else begin
                    next_state = STATE_C; // Stay in STATE_C if x is 0
                end
            end
            
            STATE_D: begin
                if (x) begin
                    g = 1; // Set g to 1 if x is 1
                    y_counter = 0; // Reset y counter
                    next_state = STATE_E; // Move to STATE_E to monitor y
                end else begin
                    next_state = STATE_C; // Go back to monitoring x
                end
            end
            
            STATE_E: begin
                g = 1; // Maintain g = 1
                if (y) begin
                    y_counter = 0; // Reset counter if y is 1
                end else if (y_counter < 2) begin
                    y_counter = y_counter + 1; // Increment counter
                end else begin
                    g = 0; // Set g = 0 if y is not 1 within 2 cycles
                    next_state = STATE_C; // Go back to monitoring x
                end
            end
        endcase
    end
endmodule