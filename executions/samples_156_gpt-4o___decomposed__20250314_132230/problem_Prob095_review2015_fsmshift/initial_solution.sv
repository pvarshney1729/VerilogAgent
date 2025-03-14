module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        STATE_IDLE   = 2'b00, // Waiting for reset or pattern detection
        STATE_ACTIVE = 2'b01, // Shift enabled for 4 cycles
        STATE_DONE   = 2'b10  // After 4 cycles, shift disabled
    } state_t;

    state_t current_state, next_state;
    logic [1:0] cycle_counter; // Counter for 4 clock cycles

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_ACTIVE;
            cycle_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_ACTIVE) begin
                cycle_counter <= cycle_counter + 1;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_IDLE: begin
                if (reset) begin
                    next_state = STATE_ACTIVE;
                end else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_ACTIVE: begin
                if (cycle_counter == 2'b11) begin
                    next_state = STATE_DONE;
                end else begin
                    next_state = STATE_ACTIVE;
                end
            end
            STATE_DONE: begin
                next_state = STATE_DONE;
            end
            default: begin
                next_state = STATE_IDLE;
            end
        endcase
    end

    // Output logic
    assign shift_ena = (current_state == STATE_ACTIVE);

endmodule