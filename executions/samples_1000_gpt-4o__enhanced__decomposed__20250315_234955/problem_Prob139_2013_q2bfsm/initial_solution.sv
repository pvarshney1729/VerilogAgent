module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;

    // State transition logic
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

    // Next state logic and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        f = 0;
        g = 0;

        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                    f = 1;
                end
            end
            STATE_B: begin
                if (x == 1) next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 0) next_state = STATE_D;
            end
            STATE_D: begin
                if (x == 1) begin
                    next_state = STATE_E;
                    g = 1;
                end
            end
            STATE_E: begin
                g = 1;
                if (y == 1) begin
                    next_state = STATE_F;
                end else if (y_counter < 2) begin
                    y_counter = y_counter + 1;
                end else begin
                    next_state = STATE_G;
                end
            end
            STATE_F: begin
                g = 1; // Maintain g = 1 permanently
            end
            STATE_G: begin
                g = 0; // Set g = 0 permanently
            end
        endcase
    end

endmodule