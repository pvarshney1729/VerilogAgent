```verilog
[BEGIN]
module TopModule (
    input logic clk,                  // Positive edge-triggered clock input
    input logic in,                   // Serial data input (assumed unsigned)
    input logic reset,                // Active-high synchronous reset
    output logic [7:0] out_byte,      // 8-bit output data byte; valid when done == 1
    output logic done                 // Indicates valid data byte reception
);

// State definitions for the FSM
typedef enum logic [2:0] {
    IDLE,           // Waiting for start bit
    RECEIVING,     // Receiving data bits
    CHECK_STOP     // Checking for stop bit
} state_t;

state_t current_state, next_state;

// Initial state assignment
always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;    // Reset FSM to IDLE state
        out_byte <= 8'b0;         // Reset output byte
        done <= 1'b0;             // Reset done flag
    end else begin
        current_state <= next_state; // Update current state 
    end
end

// FSM state transition logic
always_comb begin
    next_state = current_state; // Default to hold current state
    done = 1'b0; // Default done flag to low

    case (current_state)
        IDLE: begin
            if (in == 1'b0) begin // Detect start bit
                next_state = RECEIVING;
            end
        end
        RECEIVING: begin
            out_byte = {in, out_byte[7:1]}; // Shift left, insert new bit
            if (out_byte[7] == 1'b1) begin // Check if 8 bits received
                next_state = CHECK_STOP;
            end
        end
        CHECK_STOP: begin
            if (in == 1'b1) begin // Check for stop bit
                done = 1'b1; // Assert done when stop bit is correctly received
                next_state = IDLE; // Go back to IDLE state
            end
        end
    endcase
end

endmodule
[DONE]
```