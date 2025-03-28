module TopModule(
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C1 = 3'd2,
        STATE_C2 = 3'd3,
        STATE_C3 = 3'd4,
        STATE_D = 3'd5,
        STATE_E = 3'd6
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_wait_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            y_wait_counter <= 2'd0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_D) begin
                if (y == 1'b1)
                    y_wait_counter <= 2'd0; // Reset counter if y is 1
                else if (y_wait_counter < 2'd2)
                    y_wait_counter <= y_wait_counter + 1'd1; // Increment counter
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        f = 1'b0;
        g = 1'b0;

        case (current_state)
            STATE_A: begin
                next_state = STATE_B;
            end

            STATE_B: begin
                f = 1'b1;
                next_state = STATE_C1;
            end

            STATE_C1: begin
                if (x == 1'b1)
                    next_state = STATE_C2;
            end

            STATE_C2: begin
                if (x == 1'b0)
                    next_state = STATE_C3;
            end

            STATE_C3: begin
                if (x == 1'b1)
                    next_state = STATE_D;
            end

            STATE_D: begin
                g = 1'b1;
                if (y_wait_counter == 2'd2 && y != 1'b1)
                    next_state = STATE_E;
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