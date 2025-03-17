module TopModule(
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
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;

    // State transition logic
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        f = 0;
        g = 0;

        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (x == 0) begin
                    next_state = STATE_E;
                end
            end
            STATE_E: begin
                if (x == 1) begin
                    g = 1;
                    next_state = STATE_F;
                end
            end
            STATE_F: begin
                g = 1;
                if (y == 1) begin
                    y_counter = 0;
                end else begin
                    y_counter = y_counter + 1;
                    if (y_counter == 2) begin
                        g = 0;
                    end
                end
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule