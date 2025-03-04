module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] x_sequence;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
            if (current_state == STATE_C && x_sequence == 2'b10 && x == 1'b1) begin
                g <= 1'b1;
            end else if (current_state == STATE_D && y == 1'b1) begin
                g <= 1'b1;
            end else if (current_state == STATE_D) begin
                g <= 1'b0;
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
                x_sequence = {x_sequence[0], x};
                if (x_sequence == 2'b10 && x == 1'b1) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (y == 1'b1) begin
                    next_state = STATE_A;
                end
            end
        endcase
    end

endmodule