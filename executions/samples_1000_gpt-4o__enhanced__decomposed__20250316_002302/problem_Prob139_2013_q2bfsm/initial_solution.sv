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
        STATE_E = 3'b100
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
            if (current_state == STATE_B) begin
                x_sequence <= {x_sequence[0], x};
            end
            if (current_state == STATE_C) begin
                if (y_counter < 2'b10) begin
                    y_counter <= y_counter + 1;
                end
            end
        end
    end

    always_comb begin
        next_state = current_state;
        f = 1'b0;
        g = 1'b0;

        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                    f = 1'b1;
                end
            end
            STATE_B: begin
                if (x_sequence == 2'b10 && x == 1'b1) begin
                    next_state = STATE_C;
                end
            end
            STATE_C: begin
                g = 1'b1;
                if (y == 1'b1) begin
                    next_state = STATE_D;
                end else if (y_counter == 2'b10) begin
                    next_state = STATE_E;
                end
            end
            STATE_D: begin
                g = 1'b1;
            end
            STATE_E: begin
                g = 1'b0;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule