module TopModule (
    input logic clk,             // Clock signal, active on the rising edge
    input logic reset,           // Active-high synchronous reset signal
    input logic data,            // Serial data input (1-bit)
    input logic done_counting,   // Signal indicating counting completion (1-bit)
    input logic ack,             // Acknowledgment signal from user (1-bit)
    output logic shift_ena,      // Output to enable shifting (1-bit)
    output logic counting,       // Output indicating counting state (1-bit)
    output logic done            // Output indicating timer completion (1-bit)
);

    typedef enum logic [1:0] {
        STATE_IDLE  = 2'b00,
        STATE_SHIFT = 2'b01,
        STATE_COUNT = 2'b10,
        STATE_DONE  = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;
    logic [3:0] pattern_shift;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_IDLE;
            shift_counter <= 4'b0000;
            pattern_shift <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 4'b0000;
            end
            pattern_shift <= {pattern_shift[2:0], data};
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            STATE_IDLE: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = STATE_SHIFT;
                end
            end
            STATE_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 4'b0100) begin
                    next_state = STATE_COUNT;
                end
            end
            STATE_COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = STATE_DONE;
                end
            end
            STATE_DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = STATE_IDLE;
                end
            end
        endcase
    end

endmodule