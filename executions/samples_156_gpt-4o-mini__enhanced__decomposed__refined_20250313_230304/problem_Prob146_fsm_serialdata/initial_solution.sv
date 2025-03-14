[BEGIN]
module TopModule (
    input logic clk,                  // Clock signal (positive edge-triggered)
    input logic in,                   // Serial input bit (1 bit wide, treated as unsigned)
    input logic reset,                // Active-high synchronous reset
    output logic [7:0] out_byte,      // Output byte (8 bits wide, unsigned), valid when done is asserted
    output logic done                 // Output flag indicating byte reception completed (1 bit wide, active high)
);

typedef enum logic [1:0] {
    IDLE,
    RECEIVE,
    VERIFY_STOP
} state_t;

state_t current_state, next_state;
logic [3:0] bit_count;

always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        out_byte <= 8'b00000000;
        done <= 1'b0;
        bit_count <= 4'b0000;
    end else begin
        current_state <= next_state;
    end
end

always_ff @(posedge clk) begin
    case (current_state)
        IDLE: begin
            if (in == 1'b0) begin // Start bit detected
                next_state <= RECEIVE;
                bit_count <= 4'b0000; // Initialize bit count
            end else begin
                next_state <= IDLE;
            end
        end
        RECEIVE: begin
            out_byte[bit_count] <= in; // Capture the data bit
            if (bit_count == 4'b0111) begin
                next_state <= VERIFY_STOP; // Move to verify stop state after 8 bits
            end else begin
                bit_count <= bit_count + 1; // Increment bit count
                next_state <= RECEIVE;
            end
        end
        VERIFY_STOP: begin
            if (in == 1'b1) begin // Check for stop bit
                done <= 1'b1; // Assert done
                next_state <= IDLE; // Return to IDLE
            end else begin
                next_state <= VERIFY_STOP; // Wait for valid stop bit
            end
        end
        default: next_state <= IDLE; // Default case
    endcase
end

always_ff @(posedge clk) begin
    if (current_state != VERIFY_STOP) begin
        done <= 1'b0; // Reset done in other states
    end
end

endmodule
[DONE]