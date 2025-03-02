module TopModule (
    input logic clk,      // Clock signal, positive edge-triggered
    input logic reset,    // Active high, synchronous reset
    output logic shift_ena // Output to enable shift register
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        ENABLE = 2'b01,
        HOLD = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [2:0] cycle_count; // 3 bits to count up to 4

    localparam PROPER_PATTERN = 4'b1010; // Define the proper pattern

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= ENABLE; // Initialize to ENABLE state on reset
            cycle_count <= 3'b000;    // Reset cycle count
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold current state
        case (current_state)
            IDLE: begin
                if (/* condition to detect PROPER_PATTERN */) begin
                    next_state = ENABLE; // Transition to ENABLE on pattern detection
                end
            end
            ENABLE: begin
                if (cycle_count < 3'b011) begin
                    cycle_count = cycle_count + 1; // Increment cycle count
                    next_state = ENABLE; // Stay in ENABLE state
                end else begin
                    next_state = HOLD; // Transition to HOLD after 4 cycles
                end
            end
            HOLD: begin
                next_state = IDLE; // Transition back to IDLE
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b1; // Assert shift_ena during reset
        end else if (current_state == ENABLE) begin
            shift_ena <= 1'b1; // Assert shift_ena in ENABLE state
        end else begin
            shift_ena <= 1'b0; // Deassert shift_ena in HOLD state
        end
    end

endmodule