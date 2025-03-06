module TopModule(
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        ENABLE_SHIFT = 2'b01,
        WAIT = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= ENABLE_SHIFT;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == ENABLE_SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 2'b00;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        case (current_state)
            IDLE: begin
                // Transition logic for IDLE state
                // Assuming a specific bit pattern detection logic is required here
                // For now, we transition to ENABLE_SHIFT on reset only
                if (reset) begin
                    next_state = ENABLE_SHIFT;
                end
            end
            ENABLE_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (reset) begin
                    next_state = ENABLE_SHIFT;
                end
            end
        endcase
    end

endmodule