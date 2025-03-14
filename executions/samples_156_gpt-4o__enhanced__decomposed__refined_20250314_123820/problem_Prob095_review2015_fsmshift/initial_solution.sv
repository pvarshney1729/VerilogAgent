[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        STATE_IDLE    = 2'b00,
        STATE_ENABLE  = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [2:0] cycle_counter;
    logic reset_d;

    always_ff @(posedge clk) begin
        reset_d <= reset; // Delay reset to detect deassertion

        if (reset) begin
            current_state <= STATE_ENABLE;
            cycle_counter <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_ENABLE) begin
                cycle_counter <= cycle_counter + 1;
            end
        end
    end

    always_comb begin
        shift_ena = 1'b0;
        next_state = current_state;
        case (current_state)
            STATE_IDLE: begin
                if (reset_d && !reset) begin // Reset has just been deasserted
                    next_state = STATE_ENABLE;
                    cycle_counter = 3'b000;
                end
            end
            STATE_ENABLE: begin
                shift_ena = 1'b1;
                if (cycle_counter == 3'b011) begin
                    next_state = STATE_IDLE;
                end
            end
        endcase
    end

endmodule
[DONE]