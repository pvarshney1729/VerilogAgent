module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);
    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_G_ON = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter; // Counter for y monitoring
    logic x_prev1, x_prev2; // Registers to hold previous x values

    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
            x_prev1 <= 1'b0;
            x_prev2 <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state; // Default to hold state
        f = 1'b0; // Default output
        g = 1'b0; // Default output

        case (current_state)
            STATE_A: begin
                f = 1'b1; // Set f to 1 for one cycle
                next_state = STATE_B; // Move to next state
            end
            STATE_B: begin
                // Shift previous values
                x_prev2 = x_prev1;
                x_prev1 = x;

                // Check for the sequence 1, 0, 1
                if (x_prev2 == 1'b1 && x_prev1 == 1'b0 && x == 1'b1) begin
                    g = 1'b1; // Set g to 1 on the next clock cycle
                    next_state = STATE_C; // Move to monitoring y
                end
            end
            STATE_C: begin
                // Monitor y for the next two cycles
                if (y == 1'b1) begin
                    g = 1'b1; // Maintain g = 1 permanently
                    next_state = STATE_G_ON; // Move to g on state
                end else begin
                    y_counter = y_counter + 1; // Increment counter for y
                    if (y_counter == 2'b10) begin
                        g = 1'b0; // Set g to 0 if y is not 1 within two clock cycles
                    end
                end
            end
            STATE_G_ON: begin
                if (y == 1'b1) begin
                    g = 1'b1; // Maintain g = 1
                    y_counter = 2'b00; // Reset counter if y is 1
                end else if (y_counter < 2'b10) begin
                    y_counter = y_counter + 1; // Increment counter for y
                end else begin
                    g = 1'b0; // Set g to 0 if y doesn't become 1
                end
            end
        endcase
    end
endmodule