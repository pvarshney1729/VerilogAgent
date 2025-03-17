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
    logic [1:0] y_counter;
    logic [2:0] x_sequence;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence <= 3'b000;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end

            if (current_state == STATE_E) begin
                g <= 1'b1;
            end else if (current_state == STATE_F && y_counter == 2'b10 && !y) begin
                g <= 1'b0;
            end

            if (current_state == STATE_C || current_state == STATE_D || current_state == STATE_E) begin
                x_sequence <= {x_sequence[1:0], x};
            end

            if (current_state == STATE_F) begin
                if (y_counter < 2'b10) begin
                    y_counter <= y_counter + 1;
                end
            end else begin
                y_counter <= 2'b00;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_sequence == 3'b101) begin
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (x_sequence == 3'b101) begin
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_E;
                end
            end
            STATE_E: begin
                if (x_sequence == 3'b101) begin
                    next_state = STATE_F;
                end
            end
            STATE_F: begin
                // Remain in STATE_F until reset
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule