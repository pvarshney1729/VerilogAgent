module TopModule(
    input logic clk,           // Clock input
    input logic reset,         // Active high, synchronous reset
    input logic [3:0] pattern, // 4-bit input pattern for detection
    output logic shift_ena     // Shift enable output, active for 4 cycles
);

    typedef enum logic [1:0] {
        RESET = 2'b00,
        IDLE = 2'b01,
        ENABLE_SHIFT = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [2:0] cycle_count; // 3-bit counter to count up to 4

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= RESET;
            cycle_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == ENABLE_SHIFT || current_state == RESET) begin
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
                if (pattern == 4'b1010) begin // Assuming 1010 as the pattern to detect
                    next_state = ENABLE_SHIFT;
                end
            end
            ENABLE_SHIFT: begin
                shift_ena = 1'b1;
                if (cycle_count == 3'b011) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule