module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT_ENABLE = 2'b01,
        WAIT_FOR_PATTERN = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] shift_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT_ENABLE) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 2'b00;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;

        case (current_state)
            IDLE: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) begin
                    next_state = WAIT_FOR_PATTERN;
                end else begin
                    next_state = SHIFT_ENABLE;
                end
            end

            SHIFT_ENABLE: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) begin
                    next_state = WAIT_FOR_PATTERN;
                end
            end

            WAIT_FOR_PATTERN: begin
                // Placeholder for pattern detection logic
                // if (pattern_detected) begin
                //     next_state = SHIFT_ENABLE;
                // end
            end
        endcase
    end

endmodule