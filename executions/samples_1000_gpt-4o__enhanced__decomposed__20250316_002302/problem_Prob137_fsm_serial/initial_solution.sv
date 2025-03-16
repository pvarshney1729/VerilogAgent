module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 4'd0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 4'd0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 4'd8) // After 8 data bits
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Verify stop bit
                    next_state = IDLE;
                else
                    next_state = ERROR; // Error if stop bit is not correct
            end
            ERROR: begin
                if (in == 1'b1) // Wait for line to return to idle
                    next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
        end else begin
            if (current_state == STOP && in == 1'b1)
                done <= 1'b1;
            else
                done <= 1'b0;
        end
    end

endmodule