module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [2:0] x_pattern;
    logic [1:0] y_counter;

    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            x_pattern <= 3'b000;
            y_counter <= 0;
        end else begin
            current_state <= next_state;

            case (current_state)
                STATE_A: begin
                    f <= 1; // Set f to 1 for one clock cycle
                    next_state <= STATE_B; // Move to next state
                end
                STATE_B: begin
                    x_pattern <= {x_pattern[1:0], x}; // Shift in new x value
                    if (x_pattern == 3'b101) begin
                        g <= 1; // Set g if pattern 1, 0, 1 is detected
                        next_state <= STATE_C; // Move to state C
                    end
                end
                STATE_C: begin
                    if (y) begin
                        y_counter <= 0; // Reset counter if y is 1
                    end else if (y_counter < 2) begin
                        y_counter <= y_counter + 1; // Increment counter if y is 0
                    end
                    
                    if (y_counter >= 2) begin
                        g <= 0; // Set g to 0 if y is not 1 within two cycles
                    end
                end
            endcase
        end
    end
endmodule