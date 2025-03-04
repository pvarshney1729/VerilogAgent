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
    logic [1:0] x_sequence_counter;
    logic [1:0] y_check_counter;
    logic g_temp;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence_counter <= 2'b00;
            y_check_counter <= 2'b00;
            g_temp <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_A && next_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
            if (current_state == STATE_C && next_state == STATE_D) begin
                g <= g_temp;
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
                if (x_sequence_counter == 2'b10 && x) begin
                    next_state = STATE_C;
                    g_temp = 1'b1;
                end else if (x_sequence_counter == 2'b01 && !x) begin
                    x_sequence_counter = x_sequence_counter + 1;
                end else if (x) begin
                    x_sequence_counter = x_sequence_counter + 1;
                end else begin
                    x_sequence_counter = 2'b00;
                end
            end
            STATE_C: begin
                if (y_check_counter < 2'b10) begin
                    y_check_counter = y_check_counter + 1;
                    if (y) begin
                        g_temp = 1'b1;
                    end else if (y_check_counter == 2'b01) begin
                        g_temp = 1'b0;
                    end
                end else begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                // Final state, no transitions
            end
        endcase
    end

endmodule