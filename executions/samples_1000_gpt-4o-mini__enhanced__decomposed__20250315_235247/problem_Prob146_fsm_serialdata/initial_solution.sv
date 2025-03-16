module TopModule(
    input clk,
    input in,
    input reset,
    output logic [7:0] out_byte,
    output logic done
);
    typedef enum logic [1:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;
    logic [7:0] data_buffer;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_count <= 4'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = current_state;
        done = 1'b0; // Default done signal

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START;
                end
            end
            START: begin
                bit_count = 4'b0; // Reset bit count
                next_state = DATA; // Move to data reception
            end
            DATA: begin
                if (bit_count < 4'd8) begin
                    data_buffer[bit_count] = in; // Capture data bit
                    bit_count = bit_count + 1; // Increment bit count
                end else begin
                    next_state = STOP; // Move to stop bit check
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done = 1'b1; // Assert done
                    out_byte = data_buffer; // Output the received byte
                    next_state = IDLE; // Return to IDLE state
                end else begin
                    // Wait for a correct stop bit
                    next_state = STOP; // Stay in STOP until valid stop bit
                end
            end
            default: next_state = IDLE; // Default case
        endcase
    end
endmodule