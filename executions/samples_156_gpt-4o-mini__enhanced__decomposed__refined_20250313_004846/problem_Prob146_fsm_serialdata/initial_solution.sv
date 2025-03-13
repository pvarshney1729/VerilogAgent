```verilog
[BEGIN]
module TopModule (
    input logic clk,                // Clock signal, positive edge-triggered
    input logic in,                 // Serial input data stream, 1 bit
    input logic reset,              // Active-high synchronous reset, 1 bit
    output logic [7:0] out_byte,    // Output data byte, 8 bits
    output logic done               // Output flag indicating byte reception completion, 1 bit
);

    // State definitions
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        START   = 2'b01,
        RECEIVE = 2'b10,
        STOP    = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_counter;  // Counter for received bits
    logic [7:0] shift_reg;    // Shift register for received data

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE; // Reset FSM to IDLE state
            out_byte <= 8'b0;      // Set out_byte to zero
            done <= 1'b0;          // De-assert done
            bit_counter <= 3'b0;    // Reset bit counter
            shift_reg <= 8'b0;      // Clear shift register
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 1'b0; // Default done value

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Detect start bit
                    next_state = START;
                end
            end
            START: begin
                next_state = RECEIVE; // Transition to RECEIVE after start bit
                bit_counter = 3'b0;    // Reset bit counter
            end
            RECEIVE: begin
                shift_reg[bit_counter] = in; // Shift in data bits
                if (bit_counter == 3'b111) begin
                    next_state = STOP;
                end else begin
                    bit_counter = bit_counter + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Validate stop bit
                    out_byte = shift_reg;
                    done = 1'b1;
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE; // Default state
            end
        endcase
    end

endmodule
[DONE]
```