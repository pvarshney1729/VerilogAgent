module TopModule (
    input  logic clk,       // Clock signal, active on rising edge
    input  logic reset,     // Active-high synchronous reset
    output logic shift_ena  // Output signal to enable the shift register
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT_ENABLE = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [2:0] shift_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= SHIFT_ENABLE;
            shift_counter <= 3'b100;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT_ENABLE) begin
                if (shift_counter != 3'b000) begin
                    shift_counter <= shift_counter - 1;
                end
            end
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;

        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = SHIFT_ENABLE;
                    shift_ena = 1'b1;
                end
            end

            SHIFT_ENABLE: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'b000) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule