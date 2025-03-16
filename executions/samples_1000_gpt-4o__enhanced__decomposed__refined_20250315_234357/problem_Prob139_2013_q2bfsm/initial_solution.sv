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
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [1:0] x_sequence;
    logic [1:0] y_counter;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            x_sequence <= 2'b00;
            y_counter <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                STATE_A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
                STATE_B: begin
                    f <= 1'b1;
                end
                STATE_C: begin
                    f <= 1'b0;
                    x_sequence <= {x_sequence[0], x};
                end
                STATE_D: begin
                    g <= 1'b1;
                    if (y_counter < 2'b10)
                        y_counter <= y_counter + 1;
                end
                STATE_E: begin
                    g <= 1'b1;
                end
                STATE_F: begin
                    g <= 1'b0;
                end
            endcase
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (resetn)
                    next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_sequence == 2'b10 && x == 1'b1)
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (y == 1'b1)
                    next_state = STATE_E;
                else if (y_counter == 2'b10)
                    next_state = STATE_F;
            end
            STATE_E: begin
                // Remain in STATE_E
            end
            STATE_F: begin
                // Remain in STATE_F
            end
        endcase
    end

endmodule