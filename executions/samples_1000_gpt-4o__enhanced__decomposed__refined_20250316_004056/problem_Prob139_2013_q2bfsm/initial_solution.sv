module TopModule(
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    // State encoding
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

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            x_sequence <= 2'b00;
            y_counter <= 0;
        end else begin
            current_state <= next_state;
            case (current_state)
                STATE_A: begin
                    f <= 1;
                end
                STATE_B: begin
                    f <= 0;
                end
                STATE_C: begin
                    if (x_sequence == 2'b10 && x == 1) begin
                        g <= 1;
                    end
                end
                STATE_D: begin
                    g <= 1;
                end
                STATE_E: begin
                    if (y) begin
                        g <= 1;
                    end else if (y_counter == 2) begin
                        g <= 0;
                    end
                end
            endcase
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                x_sequence = {x_sequence[0], x};
                if (x_sequence == 2'b10 && x == 1) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                next_state = STATE_E;
            end
            STATE_E: begin
                if (y) begin
                    next_state = STATE_E;
                end else if (y_counter == 2) begin
                    next_state = STATE_A;
                end
            end
        endcase
    end

    // Y counter logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            y_counter <= 0;
        end else if (current_state == STATE_E) begin
            if (!y) begin
                y_counter <= y_counter + 1;
            end else begin
                y_counter <= 0;
            end
        end else begin
            y_counter <= 0;
        end
    end

endmodule