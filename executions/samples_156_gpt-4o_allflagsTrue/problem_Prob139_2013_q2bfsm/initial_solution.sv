module TopModule (
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
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;
    logic [2:0] x_sequence;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            x_sequence <= 3'b000;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_C) begin
                x_sequence <= {x_sequence[1:0], x};
            end
            if (current_state == STATE_D && g) begin
                y_counter <= y_counter + 1;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: if (resetn) next_state = STATE_B;
            STATE_B: next_state = STATE_C;
            STATE_C: if (x_sequence == 3'b101) next_state = STATE_D;
            STATE_D: if (y) next_state = STATE_E;
                     else if (y_counter == 2'b10) next_state = STATE_F;
            STATE_E: next_state = STATE_E; // Maintain g = 1 permanently
            STATE_F: next_state = STATE_F; // Maintain g = 0 permanently
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
        end else begin
            case (current_state)
                STATE_A: f <= 0;
                STATE_B: f <= 1;
                STATE_C: f <= 0;
                STATE_D: g <= 1;
                STATE_E: g <= 1;
                STATE_F: g <= 0;
                default: begin
                    f <= 0;
                    g <= 0;
                end
            endcase
        end
    end

endmodule