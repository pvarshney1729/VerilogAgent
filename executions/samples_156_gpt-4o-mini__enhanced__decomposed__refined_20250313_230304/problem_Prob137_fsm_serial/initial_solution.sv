```verilog
[BEGIN]
module TopModule (
    input logic clk,          // Clock signal (positive edge-triggered)
    input logic reset,        // Active-high synchronous reset
    input logic in,          // Serial input data (1-bit, unsigned)
    output logic done         // Output signal indicating successful byte reception (1-bit)
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVING = 2'b01,
        CHECK_STOP = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;      // Counter for received bits

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            bit_count <= 4'b0000;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to hold state
        done = 1'b0;                 // Default done to 0

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Detect start bit
                    bit_count = 4'b0000; // Reset bit counter
                    next_state = RECEIVING;
                end
            end
            RECEIVING: begin
                if (bit_count < 4'd8) begin
                    bit_count = bit_count + 4'b0001; // Increment bit counter
                end else begin
                    next_state = CHECK_STOP;
                end
            end
            CHECK_STOP: begin
                if (in == 1'b1) begin // Detect stop bit
                    done = 1'b1;      // Successful byte reception
                    next_state = IDLE; // Return to IDLE after done
                end
            end
        endcase
    end

endmodule
[DONE]
```