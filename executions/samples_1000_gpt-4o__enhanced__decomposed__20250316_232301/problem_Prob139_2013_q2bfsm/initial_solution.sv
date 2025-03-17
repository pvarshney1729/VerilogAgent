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
    logic [1:0] y_counter;
    logic [2:0] x_sequence;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 0;
            x_sequence <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                f <= 1;
            end else begin
                f <= 0;
            end
            if (current_state == STATE_E) begin
                g <= 1;
            end else if (current_state == STATE_D && y_counter == 2) begin
                g <= 0;
            end
            if (current_state == STATE_C || current_state == STATE_D) begin
                x_sequence <= {x_sequence[1:0], x};
            end else begin
                x_sequence <= 3'b000;
            end
            if (current_state == STATE_D) begin
                if (y) begin
                    y_counter <= 0;
                end else begin
                    y_counter <= y_counter + 1;
                end
            end else begin
                y_counter <= 0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (resetn) next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_sequence == 3'b101) next_state = STATE_D;
            end
            STATE_D: begin
                if (x_sequence == 3'b101) next_state = STATE_E;
                else if (y_counter == 2) next_state = STATE_A;
            end
            STATE_E: begin
                // Remain in STATE_E, further logic for g and y monitoring will be handled elsewhere
                next_state = STATE_E;
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule