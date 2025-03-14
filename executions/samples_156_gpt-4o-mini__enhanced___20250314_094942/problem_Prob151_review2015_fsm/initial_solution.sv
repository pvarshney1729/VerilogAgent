module TopModule (
    input logic clk,              // Clock input (1-bit)
    input logic reset,            // Synchronous reset input (1-bit, active high)
    input logic data,             // Serial data input (1-bit)
    input logic done_counting,    // Done counting signal (1-bit)
    input logic ack,              // Acknowledgment signal (1-bit)
    output logic shift_ena,       // Shift enable output (1-bit)
    output logic counting,         // Counting output (1-bit)
    output logic done             // Done output (1-bit)
);

// State Definitions
typedef enum logic [1:0] {
    IDLE = 2'b00,               // Waiting for sequence 1101
    SHIFT = 2'b01,              // Shifting in duration
    COUNTING = 2'b10,           // Waiting for counting to complete
    DONE = 2'b11                // Timer has timed out
} state_t;

state_t current_state, next_state;

// Pattern detection and shifting logic
localparam PATTERN = 4'b1101;  // Define the pattern to search for
logic [3:0] shift_reg;          // Shift register to hold incoming bits
logic [1:0] bit_count;          // Count of bits shifted

// Initial state assignment
initial begin
    current_state = IDLE;
    shift_ena = 0;
    counting = 0;
    done = 0;
    shift_reg = 4'b0000;
    bit_count = 2'b00;
end

// State Transition and Output Logic
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;    // Reset state to IDLE
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        shift_reg <= 4'b0000;
        bit_count <= 2'b00;
    end else begin
        current_state <= next_state; // Update current state
    end
end

// Next State Logic and Output Control
always @(*) begin
    // Default outputs
    next_state = current_state;
    shift_ena = 0;
    counting = 0;
    done = 0;

    case (current_state)
        IDLE: begin
            // Shift in incoming data bit
            shift_reg = {shift_reg[2:0], data};
            if (shift_reg == PATTERN) begin
                next_state = SHIFT;      // Move to SHIFT state upon pattern detection
            end
        end

        SHIFT: begin
            shift_ena = 1;              // Assert shift enable
            bit_count = bit_count + 1;  // Increment bit count
            if (bit_count == 2'b11) begin
                next_state = COUNTING;  // Move to COUNTING state after 4 bits
                bit_count = 0;          // Reset bit count
            end
        end

        COUNTING: begin
            counting = 1;               // Indicate counting is in progress
            if (done_counting) begin
                next_state = DONE;      // Move to DONE state when counting is complete
            end
        end

        DONE: begin
            done = 1;                   // Assert done output
            if (ack) begin
                next_state = IDLE;      // Wait for acknowledgment to return to IDLE
            end
        end
    endcase
end

endmodule