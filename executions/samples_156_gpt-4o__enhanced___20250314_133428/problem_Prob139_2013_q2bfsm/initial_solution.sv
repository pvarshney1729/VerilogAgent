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
        STATE_F = 3'b001,
        STATE_X1 = 3'b010,
        STATE_X0 = 3'b011,
        STATE_X1_AGAIN = 3'b100,
        STATE_B = 3'b101,
        STATE_Y1 = 3'b110,
        STATE_Y2 = 3'b111
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                y_counter <= y_counter + 1;
            end else begin
                y_counter <= 2'b00;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        f = 1'b0;
        g = 1'b0;

        case (current_state)
            STATE_A: begin
                if (resetn) next_state = STATE_F;
            end
            STATE_F: begin
                f = 1'b1;
                next_state = STATE_X1;
            end
            STATE_X1: begin
                if (x) next_state = STATE_X0;
            end
            STATE_X0: begin
                if (!x) next_state = STATE_X1_AGAIN;
            end
            STATE_X1_AGAIN: begin
                if (x) next_state = STATE_B;
            end
            STATE_B: begin
                g = 1'b1;
                if (y) next_state = STATE_Y1;
                else if (y_counter == 2'b01) next_state = STATE_Y2;
            end
            STATE_Y1: begin
                g = 1'b1;
            end
            STATE_Y2: begin
                g = 1'b0;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule