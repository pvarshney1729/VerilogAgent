module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);
    typedef enum logic [1:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count; // To count the number of received data bits

    // State register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to hold current state
        done = 1'b0; // Default done signal

        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA; // Move to data bits after start bit
                bit_count = 3'b000; // Reset bit count
            end
            DATA: begin
                if (bit_count < 3'b111) begin // If less than 8 bits received
                    bit_count = bit_count + 1; // Increment bit count
                    next_state = DATA; // Stay in DATA state
                end else begin
                    next_state = STOP; // Move to STOP state after 8 bits
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done = 1'b1; // Byte received successfully
                end
                next_state = IDLE; // Go back to IDLE state
            end
        endcase
    end
endmodule