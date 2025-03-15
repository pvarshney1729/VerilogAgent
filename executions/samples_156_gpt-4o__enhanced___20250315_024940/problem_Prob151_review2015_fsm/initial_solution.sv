module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    input  logic done_counting,
    input  logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        DETECT,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_buffer; // Buffer to hold shifted bits
    logic [1:0] shift_counter; // Counter for the shift operation

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                // Wait for pattern "1101"
                if (bit_buffer == 4'b1101) begin
                    next_state = SHIFT;
                end
                // Shift in the new bit
                bit_buffer = {bit_buffer[2:0], data};
            end

            SHIFT: begin
                // Enable shifting for 4 clock cycles
                shift_ena = 1'b1;
                shift_counter = shift_counter + 1;
                if (shift_counter == 2'b11) begin // 4 clock cycles
                    next_state = COUNT;
                end
            end

            COUNT: begin
                // Indicate counting is in progress
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end

            DONE: begin
                // Notify user that the timer has timed out
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE; // Reset to look for the next sequence
                end
            end
        endcase
    end

    // Initialize bit_buffer and shift_counter
    always @(posedge clk) begin
        if (reset) begin
            bit_buffer <= 4'b0000;
            shift_counter <= 2'b00;
        end else if (current_state == SHIFT) begin
            shift_counter <= shift_counter + 1;
        end else if (current_state == IDLE) begin
            shift_counter <= 2'b00; // Reset counter when in IDLE
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly