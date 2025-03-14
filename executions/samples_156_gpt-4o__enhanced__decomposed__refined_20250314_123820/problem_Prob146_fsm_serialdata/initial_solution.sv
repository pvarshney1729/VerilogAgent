[BEGIN]
module TopModule (
    input logic clk,             // Clock input signal
    input logic in,              // Serial data input signal
    input logic reset,           // Active-high synchronous reset
    output logic [7:0] out_byte, // 8-bit output data byte
    output logic done            // Output signal indicating data byte is valid
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,        // Default state; line is expected to be at logic 1
        START = 3'b001,       // Detects a start bit (logic 0)
        RECEIVE_DATA = 3'b010, // Captures 8 data bits, LSB first
        STOP = 3'b011,        // Verifies the stop bit (logic 1)
        WAIT_FOR_STOP = 3'b100 // Waits for the line to return to logic 1 if stop bit verification fails
    } state_t;
    
    state_t current_state, next_state; // State variables
    logic [2:0] bit_counter;
    logic [7:0] shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            shift_reg <= 8'b0;
            bit_counter <= 3'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STOP && in == 1'b1) begin
                out_byte <= shift_reg;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = RECEIVE_DATA;
                bit_counter = 3'b0;
            end
            RECEIVE_DATA: begin
                shift_reg[bit_counter] = in;
                if (bit_counter == 3'd7) begin
                    next_state = STOP;
                end else begin
                    bit_counter = bit_counter + 1'b1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_FOR_STOP;
                end
            end
            WAIT_FOR_STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]