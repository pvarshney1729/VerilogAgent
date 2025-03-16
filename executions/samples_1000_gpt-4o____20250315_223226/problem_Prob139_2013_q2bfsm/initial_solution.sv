module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic x,
    input  logic y,
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

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_E || current_state == STATE_F) begin
                y_counter <= y_counter + 1;
            end else begin
                y_counter <= 2'b00;
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
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                    f = 1'b1;
                end
            end
            STATE_B: begin
                if (x) next_state = STATE_C;
            end
            STATE_C: begin
                if (!x) next_state = STATE_D;
            end
            STATE_D: begin
                if (x) next_state = STATE_E;
            end
            STATE_E: begin
                g = 1'b1;
                if (y) begin
                    next_state = STATE_F;
                end else if (y_counter == 2'b01) begin
                    next_state = STATE_A;
                end
            end
            STATE_F: begin
                g = 1'b1;
            end
        endcase
    end

endmodule