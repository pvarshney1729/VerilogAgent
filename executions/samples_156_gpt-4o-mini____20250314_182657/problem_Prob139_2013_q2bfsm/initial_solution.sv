module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_t;

    state_t current_state, next_state;
    logic [2:0] x_counter;
    logic y_flag;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_counter <= 3'b000;
            y_flag <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_B) begin
            if (x_counter < 3'b100) begin
                x_counter <= x_counter + 1;
            end
        end else if (current_state == STATE_C) begin
            if (y_flag) begin
                g <= 1'b1;
            end else begin
                g <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            STATE_A: begin
                next_state = (resetn) ? STATE_A : STATE_B;
            end
            STATE_B: begin
                if (x_counter == 3'b100) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_C: begin
                if (y) begin
                    y_flag = 1'b1;
                    next_state = STATE_C;
                end else if (x_counter < 3'b010) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                next_state = STATE_D;
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule