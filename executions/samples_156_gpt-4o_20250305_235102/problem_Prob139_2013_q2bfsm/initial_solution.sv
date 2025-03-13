module TopModule (
    input logic clk,          // Clock input, positive edge-triggered
    input logic resetn,       // Active-low synchronous reset
    input logic x,            // Input signal x
    input logic y,            // Input signal y
    output logic f,           // Output control signal f
    output logic g            // Output control signal g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_F = 3'b001,
        STATE_X1 = 3'b010,
        STATE_X2 = 3'b011,
        STATE_X3 = 3'b100,
        STATE_Y1 = 3'b101,
        STATE_Y2 = 3'b110
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_F) f <= 1'b0;
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                f = 1'b1;
                next_state = STATE_F;
            end
            STATE_F: begin
                f = 1'b0;
                next_state = STATE_X1;
            end
            STATE_X1: begin
                if (x) next_state = STATE_X2;
            end
            STATE_X2: begin
                if (!x) next_state = STATE_X3;
                else next_state = STATE_X1;
            end
            STATE_X3: begin
                if (x) begin
                    g = 1'b1;
                    next_state = STATE_Y1;
                end else begin
                    next_state = STATE_X1;
                end
            end
            STATE_Y1: begin
                if (y) begin
                    g = 1'b1;
                    next_state = STATE_Y2;
                end else begin
                    y_counter = y_counter + 1;
                    if (y_counter == 2'b01) next_state = STATE_Y2;
                end
            end
            STATE_Y2: begin
                if (!y && y_counter == 2'b01) g = 1'b0;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule