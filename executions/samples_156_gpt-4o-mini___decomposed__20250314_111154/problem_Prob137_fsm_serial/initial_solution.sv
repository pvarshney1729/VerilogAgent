module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        WAIT_STOP
    } fsm_state_t;

    fsm_state_t current_state, next_state;
    logic [3:0] bit_count;
    logic stop_bit_verified;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'b0000;
            stop_bit_verified <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_count <= bit_count + 1'b1;
            end else if (current_state == IDLE) begin
                bit_count <= 4'b0000; // Reset bit count in idle state
            end
        end
    end

    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA; // Move to data state after start bit
            end
            DATA: begin
                if (bit_count == 4'b0111) // If 8 bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // Check stop bit
                    stop_bit_verified <= 1'b1;
                    next_state = IDLE; // If stop bit is correct, go back to idle
                end else begin
                    next_state = WAIT_STOP; // Wait for correct stop bit
                end
            end
            WAIT_STOP: begin
                if (in == 1'b1) begin // Correct stop bit detected
                    stop_bit_verified <= 1'b1;
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE; // Default state
        endcase
    end

    assign done = (current_state == IDLE) && stop_bit_verified;

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly