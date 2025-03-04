module TopModule (
    input logic clk,       // 1-bit clock signal
    input logic reset,     // 1-bit synchronous active-high reset signal
    output logic shift_ena // 1-bit output signal to enable the shift register
);

    typedef enum logic [1:0] {
        RESET = 2'b00,
        IDLE = 2'b01,
        ENABLE = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [2:0] cycle_count; // 3-bit counter to count up to 4 cycles

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= RESET;
            cycle_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == RESET || current_state == ENABLE) begin
                cycle_count <= cycle_count + 1;
            end else begin
                cycle_count <= 3'b000;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        case (current_state)
            RESET: begin
                shift_ena = 1'b1;
                if (cycle_count == 3'b011) begin
                    next_state = IDLE;
                end
            end
            IDLE: begin
                // Assume a signal `pattern_detected` indicates the proper bit pattern
                if (pattern_detected) begin
                    next_state = ENABLE;
                end
            end
            ENABLE: begin
                shift_ena = 1'b1;
                if (cycle_count == 3'b011) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule