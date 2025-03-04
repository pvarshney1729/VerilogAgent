module TopModule (
    input logic clk,        // Clock input, positive edge-triggered
    input logic resetn,     // Active low synchronous reset
    input logic x,          // Input from the motor
    input logic y,          // Input from the motor
    output logic f,         // Output to control the motor
    output logic g          // Output to control the motor
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
    logic [1:0] x_sequence_counter;
    logic [1:0] y_monitor_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            x_sequence_counter <= 2'b00;
            y_monitor_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_C) begin
                x_sequence_counter <= (x_sequence_counter == 2'b10) ? 2'b00 : x_sequence_counter + 1;
            end else begin
                x_sequence_counter <= 2'b00;
            end
            if (current_state == STATE_D) begin
                y_monitor_counter <= y_monitor_counter + 1;
            end else begin
                y_monitor_counter <= 2'b00;
            end
        end
    end

    // Next state logic
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
                if (x_sequence_counter == 2'b10 && x == 1) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (y == 1) begin
                    next_state = STATE_E;
                end else if (y_monitor_counter == 2'b01) begin
                    next_state = STATE_F;
                end
            end
            STATE_E: begin
                next_state = STATE_E;
            end
            STATE_F: begin
                next_state = STATE_F;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always_comb begin
        f = 1'b0;
        g = 1'b0;
        case (current_state)
            STATE_B: f = 1'b1;
            STATE_D: g = 1'b1;
            STATE_E: g = 1'b1;
            STATE_F: g = 1'b0;
        endcase
    end

endmodule