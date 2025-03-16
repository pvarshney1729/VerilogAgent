[BEGIN]
module TopModule(
    input logic clk,             // Clock signal, positive edge-triggered
    input logic reset,           // Active high, synchronous reset
    input logic data,            // Input data stream, 1-bit
    output logic start_shifting  // Output signal, set to 1 when sequence 1101 is detected
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        S1101 = 3'b100
    } state_t;

    // State registers
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == S1101) begin
                start_shifting <= 1'b1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        // Default assignment
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (data) 
                    next_state = S1;
            end
            S1: begin
                if (data) 
                    next_state = S11;
                else 
                    next_state = IDLE;
            end
            S11: begin
                if (~data) 
                    next_state = S110;
            end
            S110: begin
                if (data) 
                    next_state = S1101;
                else 
                    next_state = IDLE;
            end
            S1101: begin
                // Remain in S1101 indefinitely until reset
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]