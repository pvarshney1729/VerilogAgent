[BEGIN]
module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic x,
    input  logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;
    logic f_reg, g_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_E && next_state == STATE_E) begin
                y_counter <= y_counter + 1;
            end else begin
                y_counter <= 2'b00;
            end
        end

        // Update outputs based on state
        f <= f_reg;
        g <= g_reg;
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        f_reg = 1'b0; // Default output
        g_reg = 1'b0; // Default output

        case (current_state)
            STATE_A: begin
                next_state = STATE_B;
                f_reg = 1'b1; // Set f to 1 for one cycle
            end
            STATE_B: begin
                if (x) next_state = STATE_C;
            end
            STATE_C: begin
                if (!x) next_state = STATE_D;
            end
            STATE_D: begin
                if (x) next_state = STATE_E;
            end
            STATE_E: begin
                g_reg = 1'b1; // Set g to 1
                if (y) begin
                    next_state = STATE_F; // Maintain g = 1 permanently
                end else if (y_counter == 2'b10) begin
                    next_state = STATE_A; // Reset if y is not 1 within two cycles
                end
            end
            STATE_F: begin
                g_reg = 1'b1; // Maintain g = 1 permanently
            end
        endcase
    end

endmodule
[DONE]