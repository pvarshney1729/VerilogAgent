module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_buffer;
    logic [2:0] bit_count;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            data_buffer <= 8'b00000000;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START;
                end
            end

            START: begin
                next_state = DATA;
                bit_count = 3'b000; // Reset bit count
            end

            DATA: begin
                if (bit_count < 3'b111) begin
                    data_buffer[bit_count] = in; // Capture data bit
                    bit_count = bit_count + 1;
                end else begin
                    next_state = STOP;
                end
            end

            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done = 1'b1;
                    out_byte = data_buffer; // Output the received byte
                    next_state = IDLE; // Go back to IDLE
                end else begin
                    // Stay in STOP state until valid stop bit is detected
                    next_state = STOP;
                end
            end
        endcase
    end

endmodule