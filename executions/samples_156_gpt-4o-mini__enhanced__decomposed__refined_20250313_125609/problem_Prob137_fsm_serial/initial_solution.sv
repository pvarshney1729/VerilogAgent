```verilog
module TopModule (
    input logic clk,           // Clock input (1 bit)
    input logic reset,         // Active-high synchronous reset (1 bit)
    input logic in,           // Serial input data (1 bit)
    output logic done          // Output indicating byte reception complete (1 bit)
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVE,
        VERIFY_STOP
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to current state
        done = 1'b0; // Default done to low

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = RECEIVE;
                    bit_count = 3'b000;
                end
            end
            
            RECEIVE: begin
                if (bit_count < 3'b111) begin // Collecting 8 bits
                    next_state = RECEIVE;
                    bit_count = bit_count + 1;
                end else begin
                    next_state = VERIFY_STOP; // Move to verify stop after 8 bits
                end
            end
            
            VERIFY_STOP: begin
                if (in == 1'b1) begin // Stop bit verified
                    done = 1'b1; // Set done high for one clock cycle
                    next_state = IDLE; // Return to IDLE
                end
            end
            
            default: begin
                next_state = IDLE; // Default to IDLE state
            end
        endcase
    end

endmodule
```