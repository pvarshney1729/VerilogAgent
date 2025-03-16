module TopModule(
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);
    typedef enum logic [1:0] {
        STATE_A = 2'b00, // Initial state
        STATE_B = 2'b01, // Set f = 1
        STATE_C = 2'b10, // Monitor x for 101
        STATE_D = 2'b11  // Monitor y after g = 1
    } state_t;

    state_t current_state, next_state;
    logic [2:0] x_sequence; // To track the x input sequence
    logic g_temp; // Temporary signal for g
    logic f_temp; // Temporary signal for f

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence <= 3'b000;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        f_temp = 1'b0; // Default f_temp to 0
        g_temp = g; // Maintain g unless changed

        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_B; // Transition to State B
                end
            end
            
            STATE_B: begin
                f_temp = 1'b1; // Set f to 1 for one clock cycle
                next_state = STATE_C; // Move to State C
            end
            
            STATE_C: begin
                if (x_sequence == 3'b101) begin
                    g_temp = 1'b1; // Set g to 1 if sequence 101 is detected
                    next_state = STATE_D; // Move to State D
                end else begin
                    x_sequence = {x_sequence[1:0], x}; // Shift in the current x value
                end
            end
            
            STATE_D: begin
                if (y) begin
                    g_temp = 1'b1; // Maintain g = 1 if y is 1
                end else begin
                    if (g_temp) begin
                        // If g was set to 1, check for two cycles
                        if (x_sequence[1:0] == 2'b00) begin
                            g_temp = 1'b0; // Set g to 0 if y is not 1 within two cycles
                        end
                    end
                end
            end
        endcase
    end

    // Output assignments
    always @(posedge clk) begin
        f <= f_temp; // Update f
        g <= g_temp; // Update g
    end
endmodule