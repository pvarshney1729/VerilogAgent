module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE      = 3'b000,
        START     = 3'b001,
        DATA      = 3'b010,
        STOP      = 3'b011,
        WAIT_STOP = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 3'b000;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        done = 1'b0; // Default value
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end

            START: begin
                next_state = DATA;
            end

            DATA: begin
                if (bit_count == 3'd7) // After 8 data bits
                    next_state = STOP;
            end

            STOP: begin
                if (in == 1'b1) begin // Correct stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_STOP;
                end
            end

            WAIT_STOP: begin
                if (in == 1'b1) // Wait for stop bit
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule