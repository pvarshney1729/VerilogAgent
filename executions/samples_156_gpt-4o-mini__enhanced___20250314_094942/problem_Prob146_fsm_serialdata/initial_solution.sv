module TopModule (
    input logic clk,                 // Clock input, 1 bit
    input logic in,                  // Serial input data, 1 bit
    input logic reset,               // Active-high synchronous reset, 1 bit
    output logic [7:0] out_byte,     // Received data byte, 8 bits
    output logic done                // Output signal indicating byte reception, 1 bit
);

// State Definitions for FSM
typedef enum logic [2:0] {
    IDLE,          // Waiting for start bit
    RECEIVING,     // Receiving data bits
    CHECK_STOP,    // Checking for stop bit
    DONE           // Byte received, waiting for next start bit
} state_t;

// Internal FSM state
state_t current_state, next_state;
logic [3:0] bit_count; // To count the number of bits received

// Initial state and reset behavior
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        out_byte <= 8'b0;  // Reset the output byte to zero
        done <= 0;         // Reset done signal
        bit_count <= 0;    // Reset bit count
    end else begin
        current_state <= next_state; // Transition to next state
    end
end

// FSM Logic
always @(*) begin
    next_state = current_state; // Default to hold current state
    done = 0;                   // Default done signal is low
    case (current_state)
        IDLE: begin
            if (in == 1'b0) begin // Start bit detected
                bit_count = 0;    // Reset bit count
                next_state = RECEIVING;
            end
        end
        RECEIVING: begin
            if (bit_count < 8) begin
                out_byte[bit_count] = in; // Shift in data bits, LSB first
                bit_count = bit_count + 1; // Increment bit count
            end else begin
                next_state = CHECK_STOP; // Move to check for stop bit
            end
        end
        CHECK_STOP: begin
            if (in == 1'b1) begin // Stop bit detected
                done = 1;       // Assert done signal
                next_state = DONE; // Move to done state
            end
        end
        DONE: begin
            if (in == 1'b0) begin // Wait for a new start bit
                next_state = RECEIVING;
            end
        end
        default: next_state = IDLE; // Fallback to IDLE on undefined state
    endcase
end

endmodule